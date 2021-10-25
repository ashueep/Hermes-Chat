require('dotenv').config()

const express = require('express')
const app = express()
const mongoose  = require('mongoose')
const http = require('http')
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

const roles = require('./routes/roles')
app.use('/api/roles/', roles)

const messages = require('./routes/messages')
app.use('/api/messages/', messages)

const convo = require('./routes/convos')
app.use('/api/conversations/', convo)

const dm = require('./routes/dms')
app.use('/api/dms/', dm)

var https_options = {
    key: fs.readFileSync('./security/cert.key'),
    cert: fs.readFileSync('./security/cert.pem')
};

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