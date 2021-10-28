const express = require('express')
const router = express.Router()
const conversation = require('../models/conversation.model')
const message = require('../models/message.model')
const User = require('../models/users.model')
const auth = require("../middleware/auth")

//TODO: to add user auth

/*
List of permissions:

Group Permissions:

1: add channels (this will imply that the role creating the channel will have channel edit and delete permissions by default)
2: add/modify/delete roles
3: add/remove members
4. Add/edit/delete events
5. Delete group (Admin only)

Channel Permissions:

1: view messages
2: send message
3: edit (includes channel name and channel permissions)
4: delete channel (Nobody should have the permission to delete general channel)


*/

router.get('/allgroups/', async (req, res) => {
    try {
        const convos = await conversation.find()
        res.json(convos)
    } catch(err) {
        res.status(400).json(err)
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
            }]
        })

        res.user.groups.push(convo._id)
        await res.user.save()
        const toSend = await convo.save();
        res.status(201).json({group: toSend, message: "Group has beem created successfully", created: true})

    } catch(err) {
        res.status(400).json(err)
    }
})

/* 
{
    username: 
    roles: []
}
*/

router.post('/:id/adduser/', async (req, res) => {
    try {
        const convo = await conversation.findOne({ _id : req.params.id });
        const user = await User.findOne({ username : req.body.username });

        console.log('trying', user._id)

        var userRoles = []
        // 
        for(const element of convo['members']){
            console.log('id', element['memberID'].toString())
            if( element['memberID'].toString() == user._id.toString()){
                console.log('in the if')
                userRoles = element['roles']
                break;
            }
        }
        console.log('user:', userRoles)
        if( userRoles == [] ) {
            console.log('denied here : 1')
            res.status(401).send("Permission Denied.")
        } else {
            var perms = []
            userRoles.forEach(urole => {
                convo['roles'].forEach(role => {
                    if(urole == role['name']){ 
                        console.log('hiii', role['groupPermissions'])
                        perms = perms.concat(role['groupPermissions'])
                    }
                })
            })
            console.log('perms', perms)
            if(  perms.includes(3) == false ) {
                console.log('denied here : 2')
                res.status(401).send("Permission Denied.")
                return;
            }
        }
        //
        const member = await User.findOne({ username : req.body.member });

        console.log('member', member._id)

        convo['members'].push({
            memberID: member._id,
            roles: req.body.roles
        })

        const toSend = await convo.save()
        res.status(201).json(toSend)

    } catch(err) {
        res.status(400).json(err)
    }
})

module.exports = router