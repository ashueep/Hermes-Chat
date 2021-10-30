const express = require('express')
const router = express.Router()
const hasPermission = require('../middleware/hasPermission')
const isGroupMember = require('../middleware/isGroupMember')
const conversation = require('../models/conversation.model')
const message = require('../models/message.model')
const User = require('../models/users.model')
const auth = require("../middleware/auth")
const mongoose = require("mongoose")

router.post("/:id/viewAll", auth, isGroupMember, async (req, res) => {

    try{

        await res.group.populate({
            path: 'members.memberID',
            models: 'User',
            select: {'username': 1}
        })

        const members = res.group.members.map((x) =>{
            return {'username': x.memberID.username, 'roles': x.roles}
        })

        res.status(200).json({message: `Members of ${res.group.name} fetched`, members: members, success: true})
        
    } catch(err){

        res.status(500).json({message: err.message, success: false})
    }
})

router.post(":id/addMember", auth, isGroupMember, hasPermission({
    category: "Group",
    perm_number: 3
}), async (req, res) => {
    try {
        const user = await User.findOne({username: req.body.username})
        const user_id = user._id;
        if(res.group["members"].some(x => x["memberID"] == user_id)){
            return res.status(400).json({message: "User already exists!", success: false})
        }
        res.group["members"].push({
            memberID: user_id,
            roles: ["Everyone"]
        })
        const toSend = await res.group.save();
        res.status(200).json({message: "User added!", success: false, updated: toSend})
    } catch (error) {
        res.status(500).json({message: error.message, success: false})
    }
})

router.post(":id/editMemberRole", auth, isGroupMember, hasPermission({
    category: "Group",
    perm_number: 2
}), async(req, res) => {
    try {
        const member = await User.findOne({username: req.body.username})
        const mem_id = member._id;
        const ind = res.group["members"].indexOf(mem_id)

        if(req.body.roles.indexOf("Everyone") == -1)
            req.body.roles.push("Everyone");
    
        res.group["members"][ind]["roles"] = req.body.roles;

        const savedGroup = await res.group.save();
        res.status(200).json({message: "User roles updated!", success: false, updated: toSend})
    } catch (error) {
        res.status(500).json({message: error.message, success: false})
    }
})

router.post(":id/deleteMember", auth, isGroupMember, hasPermission({
    category: "Group",
    perm_number: 3
}), async(req, res) => {
    try {
        const member = await User.findOne({username: req.body.username})
        const mem_id = member._id;
        const ind_mem = res.group["members"].indexOf(mem_id)
        const ind_user = res.group["members"].indexOf(req.user._id)
        
        const mem_roles = res.group["members"][ind_mem]["roles"];
        const user_roles = res.group["members"][ind_user]["roles"];

        if(mem_id == req.user._id){
            return res.status(400).json({message: "Cannot delete yourself! Use the leave group option instead!", success: false})
        }

        if(mem_roles.includes("Admin") && !user_roles.includes("Admin")){
            return res.status(400).json({message: "Cannot remove Admin unless you have an Admin role", success: false})
        }

        res.group["members"] = res.group["members"].filter(x => x["memberID"] != mem_id)

        const savedGroup = await res.group.save();
        res.status(200).json({message: "Member removed from group!", success: false})
    } catch (error) {
        res.status(500).json({message: error.message, success: false})
    }
})

module.exports = router