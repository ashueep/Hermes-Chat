const express = require('express')
const router = express.Router()
const conversation = require('../models/conversation.model')
const message = require('../models/message.model')
const User = require('../models/users.model')

//Middleware
const auth = require("../middleware/auth")
const isGroupMember = require('../middleware/isGroupMember')

router.get('/allgroups/', async (req, res) => {
    try {
        const convos = await conversation.find()
        res.json(convos)
    } catch(err) {
        res.status(400).json(err)
    }
})

//Used while loading groups page
/*
    Send:
    1. Group id
    2. Group name
    3. List of user roles (For edit name and delete group)
*/
router.post('/getGroups/', auth, async (req, res) => {

    try {

        await res.user.populate({
            path: 'groups',
            model: 'Conversation',
            select: {'name': 1, 'members': 1, 'roles': 1}
        });

        let index = 0
        let result = []

        for(let group of res.user.groups){

            result.push({_id: group._id, name: group.name, user_roles: []})

            //Find user member from group member list
            let member = group.members.find(some_member => some_member.memberID.toString() == res.user._id.toString())
            if(!member){
                res.status(500).json({message: `Member record of corresponding user not found in group ${group.name}`, success: false})
            }

            for(let user_role of member.roles){

                let found_role = group.roles.find(some_role => some_role.name == user_role)
                if(!found_role){
                    res.status(500).json({message: `Role ${user_role} not found in group ${group.name}`, success: false})
                }

                result[index].user_roles.push(found_role)
            }

            index++
        }

        res.status(200).json({message: "Groups found", groups: result, success: true})
    } catch (err){

        res.status({message: err.message, success: false})
    }
})

//Used while loading specific group
/*
    Send:
    1. Group id
    2. Group name
    3. List of user roles (For edit name and delete channel)
    4. List of channels (name and ids)

*/
router.post('/:id/getGroup/', auth, isGroupMember, async (req, res) => {

    try{

        let group = {}
        group._id = ""
        group.name = ""
        group.user_roles = []
        group.channels = []

        group._id= res.group._id
        group.name = res.group.name

        //Find user's member record in member list
        const member = res.group.members.find(some_member =>
            some_member.memberID.toString() == res.user._id.toString())
        //Get all user's roles
        group.user_roles = res.group.roles.filter(role => member['roles'].some(user_role => user_role === role.name))

        //Get channels to whuich user has view permission
        let channelSet = new Set()
        let user_roles = []
        for(let user_role of member.roles) {

            //Find role in roles array
            let found_role = res.group.roles.find(some_role => some_role.name == user_role)
            if(!found_role){

                return res.status(404).json({message: `User role "${user_role}" not found in group`, success: false})
            }
            user_roles.push(found_role)

            if(found_role.channelPermissions){

                for(let chaPerm of found_role.channelPermissions){

                    let channel_index = res.group.channels.findIndex(channel => channel.name == chaPerm.chaName)
                    if(channel_index == -1){

                        return res.status(404).json({message: `Channel "${chaPerm.chaName}" not found in group`, success: false})
                    }

                    if(chaPerm.permissions.includes(1) && !channelSet.has(chaPerm.chaName)){

                        channelSet.add(chaPerm.chaName)

                        group.channels.push({
                            _id: res.group.channels[channel_index]._id, 
                            chaName: res.group.channels[channel_index].name
                        })
                    }
                
                }
            }
        }
        
        //Return group details
        res.status(200).json({
            message: `Fetched group "${group.name}"`, 
            group_name : res.group.name,
            user_roles: user_roles, channels: group.channels, success: true
        })
        
    } catch(err){

        res.status(500).json({message: err.message, success: false})
    }
})

router.post('/create/', auth, async (req, res) => {
    try {
        const creator = res.user

        const convo = new conversation({
            name: req.body.name,
            creatorID: creator._id,
            members: [{
                memberID: creator._id,
                roles: ['Admin', 'Everyone'] 
            }],
            channels: [{
                name: 'general',
                messages: [],
            }],
            roles: [{
                name: 'Admin',
                groupPermissions: [1,2,3,4,5],
                channelPermissions: [{
                    chaName: 'general',
                    permissions: [1,2,3]
                }]
            },
            {
                name: 'Everyone',
                groupPermissions: [],
                channelPermissions: [{
                    chaName: 'general',
                    permissions: [1,2]
                }]
            }],
            events: []
        })

        res.user.groups.push(convo._id)
        await res.user.save()
        console.log(convo)
        const toSend = await convo.save();
        res.status(201).json({group: toSend, message: "Group has been created successfully", created: true})

    } catch(err) {
        res.status(500).json(err)
    }
})

module.exports = router