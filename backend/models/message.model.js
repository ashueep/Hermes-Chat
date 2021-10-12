const mongoose = require("mongoose")

const messageSchema = mongoose.Schema({
    messageID: {
        type: String,
        required: true,
        unique: true,
    },
    sender: {
        type: String,
        required: true,
    },
    body: {
        type: String,
        required: true,
    },
    timeStamp: {
        type: Date,
        required: true,
    }
});

module.exports = mongoose.model("Message", messageSchema)
