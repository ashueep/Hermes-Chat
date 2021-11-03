const http = require('./server');
const io = require('socket.io')(http);
const message = require('./models/message.model');
const DM = require('./models/dm.model')
const user = require('./models/users.model');
const { text } = require('express');

/*

*/
console.log("socket running");
const insert = async (sender, body, room, timestamp) => {
    const dm = await DM.findById(room);
    const senderID = await user.findOne({ username: sender })
    const newmess = new message({
        senderID: senderID._id,
        body: body,
        timestamp: timestamp,
    })

    const mess = await newmess.save();
    dm['messages'].push(mess._id)
    await dm.save()
}

io.on('connection', socket => {
    socket.on('connectDM', (dmid) => {
        socket.join(dmid['dmid']);
        console.log(dmid, "has connected");
    })
    socket.on('sendDM', message => {
        room = message.room
        sender = message.sender
        text = message.text

        const time = Date.now()
        console.log("received dm");
        insert(sender, text, room, time)

        socket.in(room).emit('recvDM', {
            sender_username: sender,
            body: text,
            timestamp: "2:40"
        })

    })
    socket.on('disconnectDM', () => {
        socket.leave(chatID);
    })
})
