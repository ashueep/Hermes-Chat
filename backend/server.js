require('dotenv').config()

const express = require('express')
const app = express()
const mongoose  = require('mongoose')
const http = require('http')
const io = require('socket.io')(http, { cors : { origin : "*" } });
const message = require('./models/message.model');
const DM = require('./models/dm.model')
const user = require('./models/users.model');
const https = require('https')
const fs = require('fs')

mongoose.connect(process.env.DATABASE_URL)
const db = mongoose.connection
db.on('error', (error) => console.log(error))
db.once('open', () => console.log('Connected to database'))

app.use(express.json())

const userRouter = require('./routes/userService')
app.use('/api/userService/', userRouter)

const events = require('./routes/events')
app.use('/api/events/', events)

const channels = require('./routes/channels')
app.use('/api/channels/', channels)

const roles = require('./routes/roles')
app.use('/api/roles/', roles)

const messages = require('./routes/messages.js')
app.use('/api/messages/', messages)

const convo = require('./routes/convos')
app.use('/api/conversations/', convo)

const dm = require('./routes/dms')
app.use('/api/dms/', dm)

var https_options = {
    key: fs.readFileSync('./security/cert.key'),
    cert: fs.readFileSync('./security/cert.pem')
};

const insert = async (sender, body, room, timestamp) => {
    const dm = await DM.findById(room);
    const senderID = await user.findOne({ username : sender })
    const newmess = new message({
        senderID: senderID,
        body: body,
        timeStamp: timestamp,
    })

    const mess = await newmess.save();
    dm['messages'].push(mess._id)
    await dm.save()
}

try {
    io.on('connection', socket => {
        console.log('connected socket', socket.id)
        socket.on('connectDM', (dmid) => {
            socket.join(dmid['dmid']);
            console.log('connectDM', dmid)
        })
        socket.on('sendDM', message => {
            console.log("hello")
            room = message.room
            sender = message.sender
            text = message.text
            console.log(room)
            const time = Date.now()

            insert(sender, text, room, time)

            socket.to(room).emit('recvDM', {
                senderID: sender,
                body: text,
                timestamp: time
            })

        })
        socket.on('disconnect', () => {
            socket.leave(chatID);
        })
    })
} catch (err) {
    console.log(err)
}

//app.listen(parseInt(process.env.PORT), () => console.log("Server Started"))
const httpServer = http.createServer(app).listen(process.env.HTTP_PORT, (err) => {
    
    if(err){
        console.log(err.message)
        return
    }
    console.log(`HTTP Server Started at http://localhost:${process.env.HTTP_PORT}/`)
})

const httpsServer = https.createServer(https_options, app).listen(process.env.HTTPS_PORT, (err) => {
    
    if(err){
        console.log(err.message)
        return
    }
    console.log("HTTPS Server Started")
})

module.exports = {
    http: httpServer,
    https: httpsServer
}