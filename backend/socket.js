const { http, _ } = require('./server');
const io = require('socket.io')(http);
const message = require('./models/message.model');
const DM = require('./models/dm.model')
const user = require('./models/users.model');
const { text } = require('express');

/*

*/

const insert = async (sender, body, room, timestamp) => {
    const dm = await DM.findById(room);
    const newmess = new message({
        senderID: sender,
        body: body,
        timestamp: timestamp,
    })

    const mess = await newmess.save();
    dm['messages'].push(mess._id)
    await dm.save()
}

io.on('connection', socket => {
    socket.on('connectDM', (dmid) => {
        socket.join(dmid);
    })
    socket.on('sendDM', message => {
        room = message.room
        sender = message.sender
        text = message.text

        const time = Date.now()

        insert(sender, text, room, time)

        socket.to(room).emit('recvDM', {
            senderID: sender,
            body: text,
            timestamp: time
        })

    })
    socket.on('disconnectDM', () => {
        socket.leave(chatID);
    })
})