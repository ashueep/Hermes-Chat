const express = require('express')
const router = express.Router()
const conversation = require('../models/conversation.model')
const message = require('../models/message.model')
const User = require('../models/users.model')

//debugging
router.get('/get_roles/:id', async(req, res) => {

    const roles = await conversation.findOne(
        {memberID: req.params.id}
    )
    res.json(roles['members'][1])
})

// router.post('/create_event/', async (req, res) => {
//     try {
//         const roles = await conversation.findOne({members: req.body._id});

//     }
// })


module.exports = router