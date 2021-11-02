const express = require('express')
const router = express.Router()
const User = require('../models/users.model')
const jwt = require('jsonwebtoken')
const auth = require("../middleware/auth");

//TODO: To be removed after testing
const fs = require('fs')

//For debug purposes only
//Getting all
router.get('/getAccounts/',  async (req, res) => {

    try {

        const users = await User.find()
        res.status(200).json({users: users, success: true})
    } catch (err) {

        res.status(500).json({ message: err.message, success: false })  //Status 500: Internal Server Error
    }
})

//For debug purposes only
//Getting one
router.get('/getAccount/:id', async (req, res) => {
  
    try{
        
        let user =await User.findById(req.params.id)
        res.status(200).json({user: user, success: true})
    } catch (err){

        res.status(500).json({message: err.message, success: false})    //Status 500: Internal Server Error
    }
})

//Create account
router.post('/createAccount', async (req, res) => {

    let oldUsers
    try{

        if(!validateEmail(req.body.email)){

            return res.status(400).json({message: "Email is not valid", created: false, success: false})
        }

        //Check if user with given email already exists
        oldUsers = await User.find({email : req.body.email})
        if(!oldUsers || oldUsers.length){

            res.status(401).json({message: "Account with given email already exists", created: false, success: false})
        }
        else{

            let username, fullname

            username = req.body.username.replace(/^[w-]/g, '_')

            oldUsers = await User.find({username: username})
            if(!oldUsers || oldUsers.length){

                return res.status(400).json({message: "username already exists", created: false, success: false})
            }

            if(!("fullname" in req.body) || !req.body.fullname || !(req.body.fullname.length)){

                fullname = username
            }
            else{

                fullname = req.body.fullname
            }

            const user = new User({
                username: username,
                fullname: fullname,
                password: req.body.password,
                email: req.body.email,
                logstatus: false
            })
            try{
        
                const newUser = await user.save()
                res.status(201).json({newUser: newUser, message: "Account created successfully", created: true, success: true})   //Status 201: Created
            }catch (err) {
        
                res.status(400).json({ message: err.message, created: false, success: false })  //Status 400: Bad Request
            }
        }

    } catch(err){

        res.status(500).json({message : err.message, created: false, success: false})
    }    
})

//Update account
router.patch('/modifyAccount', auth, async (req, res) => {
    
    if (req.body.username != null) {
        
        res.user.username = req.body.username
    }
    if (req.body.password != null) {
        
        res.user.password = req.body.password
    }

    try{
    
        const updatedUser = await res.user.save()
        res.status(200).json({updatedUser: updatedUser, message: "User successfully updated", success: true})
    }catch (err) {
    
        res.status(400).json({ message: err.message, success: false })  //Status 400: Bad Request
    }
})

//Delete one
router.delete('/deleteAccount', auth, async (req, res) => {
    
    try {

        await res.user.remove()
        res.status(200).json({ message: 'Deleted User', success: true })
    } catch (err){

        res.status(500).json({ message: err.message, success: false })  //Status 500: Internal Server Error
    }
})

//TODO: This function need not use getUser
//Login
router.post('/login', async (req, res) => {

    try{

        //Find user with requested email
        const user = await User.findOne({email: req.body.email})
        if(!user){

            return res.status(404).json({message: "User with given email not found. Please create an account", logstatus: false, success: false})
        }
        res.user = user


        if(res.user.logstatus){

            res.status(200).json({message: "User is already logged in", logstatus: res.user.logstatus, success: false})
        }
        else{
            
            //Compare password with stored password
            res.user.comparePassword(req.body.password, async (error, match) => {

                if(!match){

                    return res.status(401).json({message: "Wrong email or password", logstatus: res.user.logstatus, success: false})  //Status 401: Unauthorized
                }
                else{

                    //Update log status
                    res.user.logstatus = true
                    await res.user.save()

                    const token = jwt.sign(
                        { username: res.user.username },
                        process.env.JWT_KEY,
                        {
                            expiresIn: process.env.JWT_EXPIRY   //Example: "2h"
                        }
                    );

                    //TODO: To be removed after testing
                    const content = "Email: " + res.user.email + ", Token: " + token + "\n"
                    fs.appendFile('./debug.log', content, err => {
                        if (err) {
                          console.log(err.message)
                        }
                        //file written successfully
                    })
                    res.status(200).json({message: "Login successful", logstatus: res.user.logstatus, token: token,username: res.user.username, success: true}) //Status 200: OK
                }
            })
        }
        
    } catch(err){

        res.status(500).json({message: err.message, success: false})    //Status 500: Internal server error
    }
})

//Logout
router.post('/logout', auth, async (req, res) => {
    
    try{

        if(!res.user.logstatus){
                
            res.status(200).json({message: "User is already logged out", logstatus: res.user.logstatus, success: false})
        }
        else{
    
            //Update log status
            res.user.logstatus = false
            await res.user.save()
            
            res.status(200).json({message: "Logout successful", logstatus: res.user.logstatus, success: true})
        }
    }
    catch(err){

        res.status(500).json({message: err.message, success: false})    //Status 500: Internal server error
    }
    
})

function validateEmail(email) 
{
    var re = /^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/
    return re.test(email)
}

module.exports = router