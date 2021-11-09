const User = require('../models/users.model')
const jwt = require("jsonwebtoken");

const verifyToken = async (req, res, next) => {
    
    //Verify JWT token
    const token = req.body.token || req.query.token || req.headers["x-access-token"];

    if (!token) {

        return res.status(401).json({message: "A token is required for authentication", success: false});     //Status 400: Unauthorized
    }
    try {

        const decoded = jwt.verify(token, process.env.JWT_KEY);
        req.user = decoded;
    } catch (err) {

        return res.status(401).json({message: "Invalid or Expired Token", success: false});   //Status 400: Unauthorized
    }

    //Find user with verified JWT token
    try{
         
        let user = await User.findOne({username: req.user.username})
        //console.log(req.user.username, "\n", user)
        if(!user){

            return res.status(404).json({message: "No user with given email found", success: false})    //Status 401: Not Found
        }        
        if(!user.logstatus){

            return res.status(401).json({message: "User is not logged in", success: false})     //Status 400: Unauthorized
        }
        res.user = user

    } catch (err){
        console.log(err)
        return res.status(500).json({message: err.message})     //Status 500: Server Error
    }
    return next();
};

module.exports = verifyToken;