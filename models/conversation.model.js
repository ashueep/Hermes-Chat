const mongoose = require("mongoose")

const convoSchema = mongoose.Schema({
    convoID: {
        type: String,
        required: true,
        unique: true,
    },
    convoMembers: [{
        memberID: {
            type: String,
            required: true,
        },
        roleID: {
            type: String,
            required: true,
        }
    }]
});

module.exports = mongoose.model("Conversation", convoSchema)
