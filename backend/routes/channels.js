const express = require('express')
const mongoose = require("mongoose")
const isGroupMember = require('../middleware/isGroupMember')
const auth = require('../middleware/auth')
const router = express.Router()
const conversation = require('../models/conversation.model')
// const message = require('../models/message.model')
// const User = require('../models/users.model')
const hasPermission = require('../middleware/hasPermission')

//TODO: 1. Remove check for non-existent channel name in channel permissions
router.post('/:id/addChannel', auth, isGroupMember, hasPermission({
    category: 'Group',
    perm_number: 1
}), async (req, res) => {
    try{
        const user = res.user._id.toString();

        if(res.group['channels'].some(x => x['name'] == req.body.chaName)){
            res.json({"message": "channel already exists"});
            return;
        }
        
        res.group['channels'].push({
            name: req.body.chaName,
            messages: [],
        })

        var hp = {};

        if(req.body.view != null){
            console.log('in this1 statement')
            var allroles = req.body.view
            //allroles = ["Faculty", "Admin", "Student"]
            //1: roles = "Faculty"
            //2: roles = "Admin"
            
            res.group['roles'].forEach(role => {

                if(allroles.includes(role.name)){
                    if(role['channelPermissions'].some(arrVal => arrVal['chaName'] == req.body.chaName)){
                        
                        res.status(500).json({message: `Non-existent channel present in channel permissions of role ${role.name}`, success: false})
                    }
                    else{
                        role['channelPermissions'].push({
                            chaName: req.body.chaName,
                            permissions: [1]
                        })
                    }

                }
            })
        }

        if(req.body.write != null){
            console.log('in this other statement')
            var allroles = req.body.write
            //allroles = ["Faculty", "Admin"]
            //1: roles = "Faculty"
            //2: roles = "Admin"
            res.group['roles'].forEach(role => {
                if(allroles.includes(role.name)){
                    if(role['channelPermissions'].some(arrVal => arrVal['chaName'] == req.body.chaName)){
                        var index = role['channelPermissions'].findIndex(arrVal => arrVal['chaName'] == req.body.chaName)
                        role['channelPermissions'][index]['permissions'].push(2);
                    }
                    else{
                        role['channelPermissions'].push({
                            chaName: req.body.chaName,
                            permissions: [1, 2]
                        })
                    }
                }
            })
        }

        if(req.body.edit != null){
            console.log('in this other statement')
            var allroles = req.body.edit
            //allroles = ["Faculty", "Admin"]
            //1: roles = "Faculty"
            //2: roles = "Admin"
            res.group['roles'].forEach(role => {
                if(allroles.includes(role.name)){
                    if(role['channelPermissions'].some(arrVal => arrVal['chaName'] == req.body.chaName)){
                        var index = role['channelPermissions'].findIndex(arrVal => arrVal['chaName'] == req.body.chaName)
                        role['channelPermissions'][index]['permissions'].push(3);
                    }
                    else{
                        role['channelPermissions'].push({
                            chaName: req.body.chaName,
                            permissions: [3]
                        })
                    }
                }
            })
        }

        if(req.body.delete != null){
            console.log('in this other statement')
            var allroles = req.body.delete
            //allroles = ["Faculty", "Admin"]
            //1: roles = "Faculty"
            //2: roles = "Admin"
            res.group['roles'].forEach(role => {
                if(allroles.includes(role.name)){
                    if(role['channelPermissions'].some(arrVal => arrVal['chaName'] == req.body.chaName)){
                        var index = role['channelPermissions'].findIndex(arrVal => arrVal['chaName'] == req.body.chaName)
                        role['channelPermissions'][index]['permissions'].push(4);
                    }
                    else{
                        role['channelPermissions'].push({
                            chaName: req.body.chaName,
                            permissions: [4]
                        })
                    }
                }
            })
        }

        await res.group.save()
        res.status(200).json({message: `Channel ${req.body.chaName} created`, success: true})

    } catch(err) {
        res.status(401).json({message: err.message, success: false});
    }
})


router.post("/:id/editChannel", auth, isGroupMember, hasPermission({
    category: 'Channel',
    perm_number: 4
}), async (req, res) => {
    try{
        var index = res.group['channels'].findIndex(chan => chan['name'] == req.body.chaName);
        var oldname = res.group['channels'][index]['name'];

        if(req.body.chaName == 'general'){
            res.status(400).json({message: "cannot modify general channel"})
            return;
        }

        if(req.body.newName != null){
            res.group['channels'][index]['name'] = req.body.newName;
            res.group['roles'].forEach(role => {
                var ind = role['channelPermissions'].findIndex(val => val['chaName'] == oldname);
                if(ind !== -1){
                    role['channelPermissions'][ind]['chaName'] = req.body.newName;
                }
            })
        }
        var reqJSON = {"view": 1, "write": 2, "edit": 3, "delete": 4}
        if(req.body.view != null){
            var checkname;
            if(req.body.chaName != null) checkname = req.body.newName
            else checkname = oldname;
            var allroles = req.body.view;
            res.group['roles'].forEach(role => {
                role = editChannel(allroles, role, reqJSON.view, checkname);
            })
        }
        if(req.body.write != null){
            var checkname;
            if(req.body.chaName != null) checkname = req.body.newName
            else checkname = oldname;
            var allroles = req.body.write;
            res.group['roles'].forEach(role => {
                role = editChannel(allroles, role, reqJSON.write, checkname);
            })
        }
        if(req.body.edit != null){
            var checkname;
            if(req.body.chaName != null) checkname = req.body.newName
            else checkname = oldname;
            var allroles = req.body.edit;
            res.group['roles'].forEach(role => {
                role = editChannel(allroles, role, reqJSON.edit, checkname);
            })
        }
        if(req.body.delete != null){
            var checkname;
            if(req.body.chaName != null) checkname = req.body.newName
            else checkname = oldname;
            var allroles = req.body.delete;
            res.group['roles'].forEach(role => {
                role = editChannel(allroles, role, reqJSON.delete, checkname);
            })
        }
        const toSend = await res.group.save()
        res.status(200).json(toSend)
    } catch(err) {
        res.json({"message": err.message});
    }
})

router.post('/:id/deleteChannel', auth, isGroupMember, hasPermission({
    category: "Channel",
    perm_number: 4
}), async (req, res) => {
    try {
        if(req.body.chaName == 'general'){
            res.status(400).json({message: "cannot delete general channel"})
            return;
        }

        var index = res.group['channels'].findIndex(chan => chan['name'] == req.body.chaName);

        var chanName = res.group['channels'][index]['name'];
        const query = {
            "_id": req.params.id
        }

        res.group['roles'].forEach(role => {
            if(role['channelPermissions'].some(arrVal => arrVal['chaName'] == chanName)){
                role['channelPermissions'] = role['channelPermissions'].filter(x => x['chaName'] != chanName)
            }
        })

        const groupSave = await res.group.save();

        const deleteChannel = await conversation.findOneAndUpdate(
            query,
            {'$pull': {"channels" : {"name": req.body.chaName}}},
            {safe: true}
        );
        
        res.status(200).json({saved: groupSave})
        


    } catch (err) {
        console.log(err)
        res.json({message: err.message});
    }
})

router.post("/:id/viewChannels", auth, isGroupMember, async(req, res) => {
    try {
        var userRoles = [];
        var channels = [];
        var memberx = await conversation.aggregate([{
            $match: {'_id':  mongoose.Types.ObjectId(req.params.id)}
        }, {
            $unwind: "$members"
        }, {
            $match: {'members.memberID': mongoose.Types.ObjectId(res.user._id)}
        }, {
            $project: {
                roles: "$members.roles" 
            }
        }])
        // console.log(memberx)

        userRoles = memberx[0]['roles'];
        var temp_channels = []

        res.group["roles"].forEach(role => {
            if(userRoles.includes(role.name)){
                temp_channels = temp_channels.concat(role["channelPermissions"].filter(x => x["permissions"].includes(1)))
            }
        })
        channels = channels.concat(res.group.channels.filter(x => temp_channels.some(y => y['chaName'] == x["name"])))
        // console.log(channels)

        res.status(200).json({channels: channels, message: "Channels found and sent to user", success: true})


    } catch (error) {
        console.log(error)
        res.status(400).json({message: error.message, success: false});
    }
})

function editChannel(allroles, role, perm, checkname){
    if(allroles.includes(role.name)){
        if(role['channelPermissions'].some(arrVal => arrVal['chaName'] == checkname)){
            var ind = role['channelPermissions'].findIndex(arrVal => arrVal['chaName'] == checkname)
            if(ind !== -1){
                if (!role['channelPermissions'][ind]['permissions'].includes(perm)){
                    role['channelPermissions'][ind]['permissions'].push(perm);
                }
            }
        }
    }
    else{
        if(role['channelPermissions'].some(arrVal => arrVal['chaName'] == checkname)){
            var ind = role['channelPermissions'].findIndex(arrVal => arrVal['chaName'] == checkname)
            if(ind !== -1){
                role['channelPermissions'][ind]['permissions'] =  role['channelPermissions'][ind]['permissions'].filter(item => item != perm)
                if(role['channelPermissions'][ind]['permissions'].length == 0){
                    role['channelPermissions'] = role['channelPermissions'].filter(x => x['chaName'] != checkname)
                }
            }
        }
    }
    return role;
}




module.exports = router
