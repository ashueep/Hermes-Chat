const express = require('express')
const router = express.Router()
const User = require('../models/users.model')

//Login
router.post('/', getUser, async (req, res) => {

    try{

        if(!('login' in req.body)){

            console.log(req.email)
            res.status(406).json({message: "login key required in request json to perform operation", logstatus: res.user.logstatus})    //Status 406: Not Acceptable
        }
        else if(req.body.login)
        {
            if(res.user.logstatus){

                res.status(200).json({message: "User is already logged in", logstatus: res.user.logstatus})
            }
            else{
                //Compare password with stored password
                res.user.comparePassword(req.body.password, async (error, match) => {

                    if(!match){

                        return res.status(401).json({message: "Wrong email or password", logstatus: res.user.logstatus})  //Status 401: Unauthorized
                    }
                    else{

                        //Update log status
                        res.user.logstatus = true
                        await res.user.save()
                        res.status(200).json({message: "Login successful", logstatus: res.user.logstatus}) //Status 200: OK
                    }
                })
            }
        }
        else{

            if(!res.user.logstatus){
                
                res.status(200).json({message: "User is already logged out", logstatus: res.user.logstatus})
            }
            else{

                //Update log status
                res.user.logstatus = false
                await res.user.save()
                
                res.status(200).json({message: "Logout successful", logstatus: res.user.logstatus})
            }
        }
    } catch(err){

        res.status(500).json({message: err.message})    //Status 500: Internal server error
    }
})

async function getUser(req, res, next) {
    let users
    try {
        users = await User.find({email: req.body.email})
        if (!users.length) {
        
            return res.status(404).json({ message: "Cannot find user. Please create new account"}) //Status 404: Not Found
        }
        else if(users.length > 1){

            return res.status(500).json({ message: "More than one user with given email found"})
        }
    }catch (err) {
      
        return res.status(500).json({ message: err.message })   //Status 500: Internal Server Error
    }
  
    res.user = users[0]
    next()
  }

module.exports = router