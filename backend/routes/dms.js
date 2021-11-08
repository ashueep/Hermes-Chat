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

router.post('/viewDM/', auth, async (req, res) => {
    try{
        const user=res.user;
        const userdms=res.user['dms'];
        var dms = [];
        console.log(user._id);
        console.log(dms);
        for(const dmid of userdms){
            const dm = await conversation.findById(dmid)
            console.log(1)
            const members = dm['members'].filter(x => {
                return x.toString() != user._id.toString();
            })
            console.log(members);
            var rec1;
            console.log(2)
            rec1 = await User.findById(members[0])
            console.log(3)
            dms.push({
                dmid : dm._id,
                friend: {
                    username: rec1['username'],
                    fullname: rec1['fullname'],
                    id: rec1._id
                },
                // lastmessage: dm['message'][dm['message'].length - 1] 
            })
        }
        res.status(201).json(dms)

    }catch(error){
        console.log(error)
        res.status(500).json({message: error.message, success: false})
    }
})

router.post('/create/', auth, async (req, res) => {

    try {



        const creator = res.user;

        const toadd = await User.findOne({ username : req.body.username });



        if(!toadd) {

            res.status(400).json({ message : 'User to contact not found' })

            return;

        }

        //Check if DM already exists
         //const existing = await conversation.find({members: { $all : [creator._id, toadd._id]}})
         //if(existing){

         //    return res.status(400).json({message: "DM already found", created: false})
         //}

        const dm = new conversation({

            members: [creator._id, toadd._id],

            messages: []

        })



        const toSend = await dm.save();



        creator['dms'].push(toSend._id)

        toadd['dms'].push(toSend._id)


        await creator.save()
        await toadd.save()
        
        res.status(201).json({

            user_id: toadd._id,

            fullname: toadd.fullname,

            dm_id: dm._id,

            message : 'DM created' })



    } catch(err) {
        console.log(err)
        res.status(500).json({ message : err.message })

    }

})



/*

{

    token:

}

*/



router.post('/:id/view/', auth, async (req, res) => {

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


        // console.log(dm['messages'])
        // console.log("hello");
        for(const mess of dm['messages']){
            const mid = dm['messages'][mess]
            console.log(mess)
            console.log('messageid mid: ', mess)
            const m = await message.findOne({ _id : mess })
            const sender = await User.findById(m.senderID)
            messages.push({
                sender: sender.username,
                body: m.body,
                timeStamp: m.timeStamp
            })
        }

        console.log(messages)

        res.status(200).json(messages)



    } catch(err) {
        console.log(err)
        res.status(500).json({ message : err })

    }

})



module.exports = router