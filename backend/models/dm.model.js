const mongoose = require("mongoose")

const dmSchema = mongoose.Schema({
    members: [{
        type: mongoose.Types.ObjectId,
        ref: 'User',
        require: true,
    }],
    messages: [{
        type: mongoose.Types.ObjectId,
        ref: 'Message',
    }]
});

module.exports = mongoose.model("DM", dmSchema)
