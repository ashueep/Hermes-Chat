const express = require('express')
const router = express.Router()

const conversation = require('../models/conversation.model')
const User = require('../models/users.model')
const auth = require("../middleware/auth")
const isGroupMember = require('../middleware/isGroupMember')
const hasPermission = require('../middleware/hasPermission')


router.get('/:id/getAll', auth, isGroupMember, hasPermission({
    category: 'Group',
    perm_number: 2
}), async (req, res) => {

    try{ 

        const roles = res.group['roles']
        res.status(200).json({message: "Found roles", roles: roles, success: true})

    } catch (err){

        res.status(500).json({message: err.message, success: false})
    }
})

/*
router.post('/:group_id/', auth, isGroupMember, hasPermission, async (req, res) => {


})

*/

/*
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
*/

module.exports = router