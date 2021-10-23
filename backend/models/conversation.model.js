const mongoose = require("mongoose")

const convoSchema = mongoose.Schema({
    name: {
        type: String,
    },
    creatorID: {
        type: mongoose.Types.ObjectId,
        ref: 'User',
        require: true,
    },
    members: [{
        memberID: {
            type: mongoose.Types.ObjectId,
            ref: 'User',
            require: true,
        },
        roles: [String],
    }],
    channels: [{
        name: {
            type: String,
            required: true,
        },
        messages: [{ type: mongoose.Types.ObjectId, ref: 'Message' }],
    }],
    roles: [{
        name: {
            type: String,
            require: true,
        },
        groupPermissions: [Number],
        channelPermissions: [{
            chaName: String,
            permissions: [Number]
        }]
    }],
    events: [{
        name: {
            type: String,
            required: true,
        },
        datetime: {
            type: Date,
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
