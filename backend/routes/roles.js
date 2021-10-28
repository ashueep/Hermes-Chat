const express = require('express')
const router = express.Router()

const conversation = require('../models/conversation.model')
const auth = require("../middleware/auth")
const isGroupMember = require('../middleware/isGroupMember')
const hasPermission = require('../middleware/hasPermission')


router.post('/:id/getAll', auth, isGroupMember, async (req, res) => {

    try{ 

        const roles = res.group['roles']
        res.status(200).json({message: "Found roles", roles: roles, success: true})

    } catch (err){

        res.status(500).json({message: err.message, success: false})
    }
})

router.post('/:id/getOne', auth, isGroupMember, async (req, res) => {

    try{ 

        const roles = res.group.roles.find(x => x['name'] == req.body.name)
        if(!role){
            
            return res.status(404).json({message: "Role not found", success: false})
        }
        res.status(200).json({message: "Found roles", roles: roles, success: true})

    } catch (err){

        res.status(500).json({message: err.message, success: false})
    }
})


router.post('/:id/addRole', auth, isGroupMember, hasPermission({
    category: 'Group',
    perm_number: 2
}), async (req, res) => {

    try{ 

        if(!req.body.name){

            return res.status(400).json({message: "Name of role missing", success: false})
        }

        //Check if role with same name already exists
        if(res.group.roles.some(role => role['name'] == req.body.name)){
            
            return res.status(400).json({message: "Role with the same name already exists", success: false})
        }

        let groupPermissions = []
        if(req.body.groupPermissions){

            //Check format of group permissions
            if(!Array.isArray(req.body.groupPermissions) &&
                req.body.groupPermissions.some((x) => {return !(Number.isInteger(x) && x > 0 && x < 6);} )){

                return res.status(400).json({message: "Wrong format of group permissions", success: false})
            }

            groupPermissions = req.body.groupPermissions
        }

        //Create new role with base level of permissions
        res.group.roles.push({
                name: req.body.name,
                groupPermissions: groupPermissions,
                channelPermissions: [{
                    chaName: 'general',
                    permissions: [1,2]
                }]
            }
        )


        await res.group.save()
        //console.log(res.group.roles)
        res.status(201).json({message: `Role ${req.body.name} created`, success: true})

    } catch (err){

        res.status(500).json({message: err.message, success: false})
    }
})

router.post('/:id/deleteRole', auth, isGroupMember, hasPermission({
    category: 'Group',
    perm_number: 2
}), async (req, res) => {

    try{ 

        if(!req.body.name){

            return res.status(400).json({message: "Name of role missing", success: false})
        }

        //Check if role with same name already exists
        //console.log(res.group.roles)
        const role = res.group.roles.find(x => x['name'] == req.body.name)
        if(!role){
            
            return res.status(404).json({message: "Role not found", success: false})
        }

        //Filter out roles from attendees of events
        res.group['events'].forEach(event => {
            event['attendees'] = event['attendees'].filter(x => x != req.body.name)
        });

        //Filter out roles from members
        res.group['members'].forEach(member => {
            member['roles'] = member['roles'].filter(x => x != req.body.name)
        });

        //Filter out roles
        res.group.roles = res.group.roles.filter(x => x['name'] != req.body.name)

        await res.group.save()

        /*
        await conversation.findByIdAndUpdate(res.group['_id'], { 
            $pull: {
                roles: { name: req.body.name}
            }
        })
        */
        
        res.status(200).json({message: `Deleted role ${req.body.name}`, success: true})

    } catch (err){

        res.status(500).json({message: err.message, success: false})
    }
})

router.post('/:id/editRole', auth, isGroupMember, hasPermission({
    category: 'Group',
    perm_number: 2
}), async (req, res) => {

    try{ 

        if(!req.body.name){

            return res.status(400).json({message: "Name of role missing", success: false})
        }

        //Check if role with same name already exists
        //console.log(res.group.roles)
        const role = res.group.roles.find(x => x['name'] == req.body.name)
        if(!role){
            
            return res.status(404).json({message: "Role not found", success: false})
        }

        if(req.body.name == 'Everyone'){

            return res.status(400).json({message: "Cannot modify role Everyone", success: false})
        }
        if(req.body.name == 'Admin'){

            return res.status(400).json({message: "Cannot modify role Admin", success: false})
        }

        const query = {

            "roles._id": role._id
        }
        var eventJSON = {};
        if(req.body.newname != null && req.body.newname != req.body.name){

            //Check if role with same name already exists
            if(res.group.roles.some(x => x['name'] == req.body.newname)){
                
                return res.status(400).json({message: "Role with the same name already exists", success: false})
            }
            eventJSON["roles.$.name"] = req.body.newname;
        }
        if(req.body.groupPermissions != null){

            if(!Array.isArray(req.body.groupPermissions) &&
                req.body.groupPermissions.some((x) => {return !(Number.isInteger(x) && x > 0 && x < 6);} )){

                return res.status(400).json({message: "Wrong format of group permissions", success: false})
            }

            eventJSON["roles.$.groupPermissions"] = req.body.groupPermissions;
        }
        console.log(JSON.stringify(eventJSON))
        await conversation.updateOne(query, {'$set': eventJSON})
        res.status(200).json({message: `Updated role ${req.body.name}`, success: true})

    } catch (err){

        res.status(500).json({message: err.message, success: false})
    }
})



module.exports = router