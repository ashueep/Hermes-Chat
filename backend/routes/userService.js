const express = require('express')
const router = express.Router()
const User = require('../models/users.model')

//Getting all
router.get('/', async (req, res) => {

    try {

        const users = await User.find()
        res.json(users)
    } catch (err) {

        res.status(500).json({ message: err.message })  //Status 500: Internal Server Error
    }
})

//Getting one
router.get('/:id', getUser, (req, res) => {
  
    res.json(res.user)
})

//Create one
router.post('/', async (req, res) => {

    const user = new User({
        username: req.body.username,
        password: req.body.password,
        email: req.body.email
    })
    try{

        const newUser = await user.save()
        res.status(201).json(newUser)   //Status 201: Created
    }catch (err) {

        res.status(400).json({ message: err.message })  //Status 400: Bad Request
    }
})

//Update one
router.patch('/:id', getUser, async (req, res) => {
    
    if (req.body.username != null) {
        
        res.user.username = req.body.username
    }
    if (req.body.password != null) {
        
        res.user.password = req.body.password
    }
    if (req.body.email != null) {
        
        res.user.email = req.body.email
    }
    try{
    
        const updatedUser = await res.user.save()
        res.json(updatedUser)
    }catch (err) {
    
        res.status(400).json({ message: err.message })  //Status 400: Bad Request
    }
})

//Delete one
router.delete('/:id', getUser, async (req, res) => {
    
    try {

        await res.user.remove()
        res.json({ message: 'Deleted User' })
    } catch (err){

        res.status(500).json({ message: err.message })  //Status 500: Internal Server Error
    }
})

async function getUser(req, res, next) {
    let user
    try {
        user = await User.findById(req.params.id)
        if (user == null) {
        
            return res.status(404).json({ message: 'Cannot find user' })
        }
    }catch (err) {
      
        return res.status(500).json({ message: err.message })   //Status 500: Internal Server Error
    }
  
    res.user = user
    next()
  }

module.exports = router