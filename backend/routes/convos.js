const express = require('express')
const router = express.Router()
const conversation = require('../models/conversation.model')
const message = require('../models/message.model')
const User = require('../models/users.model')

//TODO: to add user auth

/*
groupPermissions
1: add channels
2: add roles
3: add/remove members
*/

/*
channelPermissions
1: view messages
2: send message
3: 

*/

router.get('/allgroups/', async (req, res) => {
    try {
        const convos = await conversation.find()
        res.json(convos)
    } catch(err) {
        res.status(400).json(err)
    }
})

router.post('/create/', async (req, res) => {
    try {
        const creator = await User.findOne({ username: req.body.username })

        const convo = new conversation({
            name: req.body.name,
            creatorID: creator._id,
            members: [{
                memberID: creator._id,
                roles: ['Admin'] 
            }],
            channels: [{
                name: 'general',
                messages: [],
            }],
            roles: [{
                name: 'Admin',
                groupPermissions: [1,2,3,4,5,6,7],
                channelPermissions: [{
                    chaName: 'general',
                    permissions: [1,2,3,4,5,6,7]
                }]
            }]
        })

        const toSend = await convo.save();
        res.status(201).json(toSend)

    } catch(err) {
        res.status(400).json(err)
    }
})

router.post('/:id/addchannel/', async (req, res) => {
    try{

        const convo = await conversation.findOne({ _id : req.params.id });
        const username = await User.findOne({ username : req.body.username });
        const user = username._id;
        
        var userRoles = []
        // 
        for(const element of convo['members']){
            console.log('id', element['memberID'])
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
            if(  perms.includes(1) == false ) {
                console.log('denied here : 2')
                res.status(401).send("Permission Denied.")
                return;
            }
        }
        //

        convo['channels'].push({
            name: req.body.name,
            messages: [],
        })

        if(req.body.view != null){
            var allroles = req.body.view
            for(const role of allroles){
                for(let i = 0 ; i < convo['roles'].length ; i++){
                    if(convo['roles'][i]['name'] == role){
                        convo['roles'][i]['channelPermissions'].push({
                            chaName: req.body.name,
                            permissions: [1]
                        })
                    }
                }
            }
        }

        if(req.body.write != null){
            var allroles = req.body.write
            for(const role of allroles){
                for(let i = 0 ; i < convo['roles'].length ; i++){
                    if(convo['roles'][i]['name'] == role){
                        convo['roles'][i]['channelPermissions'].push({
                            chaName: req.body.name,
                            permissions: [2]
                        })
                    }
                }
            }
        }

        const toSend = await convo.save()
        res.status(201).json(toSend)

    } catch(err) {
        res.status(201).json(err);
    }
})

router.post('/:id/addrole/', async (req, res) => {
    try{

        const convo = await conversation.findOne({ _id : req.params.id });
        const username = await User.findOne({ username : req.body.username });
        const user = username._id;
        
        var userRoles = []
        // 
        for(const element of convo['members']){
            console.log('id', element['memberID'])
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
            if(  perms.includes(2) == false ) {
                console.log('denied here : 2')
                res.status(401).send("Permission Denied.")
                return;
            }
        }
        //

        convo['roles'].push({
            name: req.body.role,
            groupPermissions: req.body.groupPermissions,
            channelPermissions: req.body.channelPermissions
        })

        const toSend = await convo.save()
        res.status(201).json(toSend)

    } catch(err) {
        res.status(201).json(err);
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