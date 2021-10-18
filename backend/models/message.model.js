const mongoose = require("mongoose")

const messageSchema = mongoose.Schema({
    senderID: {
        type: mongoose.Types.ObjectId,
        ref: 'User',
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

const Message = mongoose.model('Message', messageSchema)

module.exports = Message
