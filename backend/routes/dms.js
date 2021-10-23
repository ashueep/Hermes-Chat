const express = require('express')
const router = express.Router()
const conversation = require('../models/dm.model')
const message = require('../models/message.model')
const User = require('../models/users.model')
const auth = require('../middleware/auth')


/* 
{
    token: 
    secondusername: 
}
*/
router.post('/create/', auth, async (req, res) => {
    try {

        const creator = res.user;
        const toadd = await User.findOne({ username : req.body.username });

        if(!toadd) {
            res.status(400).json({ message : 'User not found' })
            return;
        }

        const dm = new conversation({
            members: [creator._id, toadd._id],
            messages: []
        })

        const toSend = await dm.save();

        creator['dms'].push(toSend._id)
        toadd['dms'].push(toSend._id)

        res.status(201).json({ dm : toSend, message : 'DM created' })

    } catch(err) {
        res.status(500).json({ message : err.message })
    }
})

/* 
{
    token:
}
*/

router.get('/:id/view/', auth, async (req, res) => {
    try {

        const user = res.user
        const dm = await conversation.findOne({ _id : req.params.id })

        if(dm['members'].includes(user._id) == false){
            res.status(401).json({ message : "Permission denied." })
            return
        }
        //dm[m] = {1,2,3,,45}
        //messages = []
        var messages = [];

        for(const mess in dm['messages']){
            const m = await message.findOne({ _id : mess })
            messages.push(m)
        }

        res.status(200).json({messages : messages})

    } catch(err) {
        res.status(500).json({ message : err.message })
    }
})

module.exports = router