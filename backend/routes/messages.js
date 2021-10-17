const express = require('express')
const router = express.Router()
const message = require('../models/message.model')
const userAuth = require('../models/users.model')

//TODO: To add users authenticaion via cookies/tokens.

router.get('/view', async (req, res) => {
    try{
    const mess = await message.find();
    res.json(mess)
    } catch(err){
        res.status(201).json(err);
    }
})

router.post('/post', async (req, res) => {
    const userID = await userAuth.findOne({
        username: req.body.username,
    });

    // console.log(userID._id)

    const mess = new message({
        senderID: userID._id,
        body: req.body.message,
        timeStamp: Date.now() 
    })
    try{
        
    const toSend = await mess.save()
    res.status(201).json(toSend)
    } catch(error) {
        console.log(error)
    }

    // res.send('done')
})

module.exports = router