const mongoose = require('mongoose');
const conversation = require('../models/conversation.model')

function hasRolePermission(toCheck){

    return async function (req, res, next){

        try {
            if(toCheck.category == 'Channel'){
                if(!res.group['channels'].some(x => x['name'] == req.body.chaName)){
                    res.status(400).json({message: "channel does not exist", success: false});
                    return;
                }
            }

            //Get roles with required permissions
            const req_user_id = res.user._id.toString();
            //console.log(req.params.id)
            var userRoles = []
            var memberx = await conversation.aggregate([{
                $match: {'_id':  mongoose.Types.ObjectId(req.params.id)}
            }, {
                $unwind: "$members"
            }, {
                $match: {'members.memberID': mongoose.Types.ObjectId(req_user_id)}
            }, {
                $project: {
                    roles: "$members.roles" 
                }
            }])
            // console.log(memberx)

            userRoles = memberx[0]['roles'];
            //console.log(member['roles']);
            if( userRoles == [] ) {

                //console.log('denied here : 1')
                return res.status(500).json({message: "Server error. No roles for user found", success: false})
            } else {

                var perms = new Set()
                res.group['roles'].forEach(role => {
                    
                    if(userRoles.includes(role.name)){ 

                        if(toCheck.category == 'Group'){
                            // console.log('hiii', role['groupPermissions'])
                            role['groupPermissions'].forEach(group_perm => perms.add(group_perm))                            
                        }
                        else if(toCheck.category == 'Channel'){
                            const channel_perms = role['channelPermissions'].filter(function (channel) {
                                return channel.chaName == req.body.chaName;
                            })[0]['permissions']
                            channel_perms.forEach(cperm => perms.add(cperm))
                        }
                        else{

                            return res.status(500).json({message: "Internal Server Error",success: false})
                        }
                    }
                })

                //console.log('perms', perms)
                if( perms.has(toCheck.perm_number) == false ) {

                    //console.log('denied here : 2')
                    return res.status(401).json({message: "Permission Denied.", success: false})
                }
            }
            
        } catch(err){
            return res.status(500).json({message: err.message, success: false})
        }

        return next()
    }
}

module.exports = hasRolePermission