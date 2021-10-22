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

const messages = require('./routes/messages.js')
app.use('/api/messages/', messages)

const convo = require('./routes/convos')
app.use('/api/conversations/', convo)

var https_options = {
    key: fs.readFileSync('./cert/CA/HermesHost/HermesHost.decrypted.key'),
    cert: fs.readFileSync('./cert/CA/HermesHost/HermesHost.crt')
};

//app.listen(parseInt(process.env.PORT), () => console.log("Server Started"))
http.createServer(app).listen(process.env.HTTP_PORT, () => console.log("HTTP Server Started"))
https.createServer(https_options, app).listen(process.env.HTTPS_PORT, () => console.log("HTTPS Server Started"))