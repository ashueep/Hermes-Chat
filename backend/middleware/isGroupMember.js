const conversation = require('../models/conversation.model')

const isGroupMember = async (req, res, next) => {

    try {

        const group = await conversation.findById(req.params.id)
        if(!res.user['groups'].includes(req.params.id) || !group){
            return res.status(404).json({message: "Requested group does not exist or the user is not part of the group", found: false})
        }

        res.group = group
    } catch(err){

        return res.status(500).json({message: err.message, success: false})
    }

    return next()
}

module.exports = isGroupMember