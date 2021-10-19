require('dotenv').config()

const express = require('express')
const app = express()
const mongoose  = require('mongoose')

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

app.listen(parseInt(process.env.PORT), () => console.log("Server Started"))