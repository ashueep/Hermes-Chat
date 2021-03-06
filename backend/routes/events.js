const express = require('express')
const isGroupMember = require('../middleware/isGroupMember')
const auth = require('../middleware/auth')
const hasPermission = require('../middleware/hasPermission')
const router = express.Router()
const conversation = require('../models/conversation.model')
const message = require('../models/message.model')
const User = require('../models/users.model')
const mongoose = require('mongoose')

//debugging
router.get('/get_roles/:id/:m_id', auth,async(req, res) => {

    const group = await conversation.findById(
        req.params.id
    );
    const roles = await group['members'];

    res.json(group)
    console.log(group)
})
//

router.post("/:id/viewEvents", auth, isGroupMember, async(req, res) =>{
    try {
        const user_id = res.user._id;
        var userRoles = []
        var memberx = await conversation.aggregate([{
            $match: {'_id':  mongoose.Types.ObjectId(req.params.id)}
        }, {
            $unwind: "$members"
        }, {
            $match: {'members.memberID': mongoose.Types.ObjectId(user_id)}
        }, {
            $project: {
                roles: "$members.roles" 
            }
        }])
        // console.log(memberx)
        userRoles = memberx[0]['roles'];
        console.log(userRoles)
        
        var eventx = await conversation.aggregate([{
            $match: {'_id': mongoose.Types.ObjectId(req.params.id)}
        }, {
            $unwind: "$events"
        }, {
            $match: {"events.attendees": {$in: userRoles}}
        }, {
            $project: {
                events: "$events"
            }
        }])
        

        res.status(200).json({message: "Events fetched!", "result": eventx, success: true})


    } catch (err) {
        res.status(500).json({message: err.message, success: false})
    }
})

router.post('/:id/createEvent', auth, isGroupMember, hasPermission({
    category: "Group",
    perm_number: 4
}),async (req, res) => {
    try {
        if(req.body.name == null){
            return res.status(401).json({message: "Event name has to be provided", success: false})
        }
        else{
            if(req.body.attendees != null){
                req.body.attendees.forEach(role => {
                    if(!res.group["roles"].some(x => x["name"] == role)){
                        return res.status(400).json({message: "Some/All roles don't exist in the group! Please enter the correct roles!", success: false})
                    }
                })
            }
            res.group.events.push({
                name: req.body.name,
                datetime: req.body.datetime,
                description: req.body.description,
                attendees: ["Everyone"]
            })

            const updatedConvo = await res.group.save()
            res.json({"result": updatedConvo, message: `Event "${req.body.name}" created!`, success: true})

        }


    } catch(err) {
        console.log(err)
        res.status(500).json({message: err.message})
    }
})

router.post("/:id/updateEvent", auth, isGroupMember, hasPermission({
    category: "Group",
    perm_number: 4
}),async(req, res) => {
    try{
        const query = {
            "events._id": req.body.id
        }
        var eventJSON = {};
        if(req.body.name != null){
            eventJSON["events.$.name"] = req.body.name;
        }
        if(req.body.description != null){
            eventJSON["events.$.description"] = req.body.description;
        }
        if(req.body.datetime != null){
            eventJSON["events.$.datetime"] = req.body.datetime;
        }
        if(req.body.attendees != null){
            eventJSON["events.$.attendees"] = req.body.attendees;
        }
        const updateEvent = await conversation.updateOne(query, 
            {'$set': eventJSON})
        
        res.status(200).json({message: "Event Member List Edited", success: true, event: updateEvent})
    } catch(err){
        res.status(500).json({message: err.message, success: false})
    }
})

router.post('/:id/deleteEvent', auth, isGroupMember, hasPermission({
    category: "Group",
    perm_number: 4
}), async (req, res) => {
    try {
        const query = {
            "_id": req.params.id
        }
        const deleteEvent = await conversation.findOneAndUpdate(
            query,
            {'$pull': {"events" : {"_id": req.body.id}}},
            {safe: true}
        );

        res.status(200).json({message: "Event successfully deleted!", success: true})

    } catch (err) {
        res.status(500).json({message: err.message, success: false})
    }
})

module.exports = router