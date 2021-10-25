const mongoose = require("mongoose")

const memberSchema = mongoose.Schema({
    memberID: {
        type: mongoose.Types.ObjectId,
        ref: 'User',
        require: true,
    },
    roles: [String],
})

const convoSchema = mongoose.Schema({
    name: {
        type: String,
    },
    creatorID: {
        type: mongoose.Types.ObjectId,
        ref: 'User',
        require: true,
    },
    members: [memberSchema],
    channels: [{
        name: {
            type: String,
            required: true,
            unique: true,
        },
        messages: [{ type: mongoose.Types.ObjectId, ref: 'Message' }],
    }],
    roles: [{
        name: {
            type: String,
            required: true,
            unique: true,
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
            required: true
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
