const mongoose = require("mongoose");
const bcrypt = require("bcryptjs")

const Schema = mongoose.Schema;

const userSchema = Schema({
    username: {
        type: String,
        unique: true,
        require: true
    },
    fullname: {
        type: String    //Not required (if not specified, username is taken as full name)
    },
    password: {
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: true,
        unique: true,
    },
    logstatus: {

        type: Boolean,
        required: true
    }
});

userSchema.pre("save", function(next){
    const user = this

    if(this.isModified("password") || this.isNew){
        bcrypt.genSalt(10, function (saltError, salt){
            if(saltError){
                return next(saltError)
            } else {
                bcrypt.hash(user.password, salt, function(hashError, hash){
                    if (hashError){
                        return next(hashError)
                    }

                    user.password = hash
                    next()
                })
            }
        })
    } else {
        return next()
    }
})

userSchema.methods.comparePassword = function(password, callback) {
    bcrypt.compare(password, this.password, function(error, isMatch) {
        if (error) {
            return callback(error)
        } else {
            callback(null, isMatch)
        }
    })
}

const User = mongoose.model('User', userSchema);
module.exports = User