const mongoose = require("mongoose")

const memberSchema = mongoose.Schema({
    memberID: {
        type: mongoose.Types.ObjectId,
        ref: 'User'
    },
    roles: [String],
})

const convoSchema = mongoose.Schema({
    name: {
        type: String,
    },
    creatorID: {
        type: mongoose.Types.ObjectId,
        ref: 'User'
    },
    members: [memberSchema],
    channels: [{
        name: {
            type: String
        },
        messages: [{ type: mongoose.Types.ObjectId, ref: 'Message' }],
    }],
    roles: [{
        name: {
            type: String
        },
        groupPermissions: [Number],
        channelPermissions: [{
            chaName: {
                type: String
            },
            permissions: [Number]
        }]
    }],
    events: [{
        name: {
            type: String
        },
        datetime: {
            type: String,
        },
        description: {
            type: String,
        },
        attendees: [{
            type: String,
        }]
    }]
});

module.exports = mongoose.model("Conversation", convoSchema)
