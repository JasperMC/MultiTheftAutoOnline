const express = require("express");
const bodyParser = require('body-parser');
const router = express.Router();
const config = require("../config");
const databaseUser = require("../database/user");
const mysql = require("mysql");
const jwt = require("jsonwebtoken");
// /User

// Get User Details
router.get("/", (req, res) => {
    const connection = mysql.createConnection( config.db )
    connection.query("SELECT * FROM mta.users;", (error, rows, fields) => {
        if ( error ) throw error;
        res.status(200).json(rows);
    }
    );

});

// User Login
router.post("/login", bodyParser.json(), (req, res) => {
    console.log(req.body)
    const { method, credentials} = req.body;
    switch(method) {
        case "email_password": {
            if(credentials["email"] && credentials["password"]) {
                const connection = mysql.createConnection( config.db )
                connection.query("SELECT id, username FROM mta.users WHERE email = ? AND password = ?;", [credentials["email"],credentials["password"]], (error, rows, fields) => {
                if ( error ) throw error;
                if(rows.length == 1) {
                        //console.log(config.jwt_secret);
                        rows[0]['token'] = jwt.sign({ "userId": rows[0]['id'] }, config.jwt_secret, {expiresIn: '1h'})
                        res.status(200).json(rows);
                }
                else if(rows.length > 1) {
                    res.status(500).json({"message":"Multiple accounts with same e-mail address"});
                }
                else {
                    res.status(401).json({"message": "Invalid login credentials"});
                }
                });
            }
            else {
                res.status(401).json({"message": "Missing email or password"});
            }
        }            
        res.status(500);
    }

});

// User Update
router.put("/", (req, res) => {

});

// User Delete
router.delete("/", (req, res) => {

});

// Registration
router.post('/register', async(req, res) => {
    try {
        const {username, email, password } = req.body
        // Check if username already exists


        const hashedPassword = await bcrypt.hash(password, 10);
        dbU = new databaseUser()
        id = dbU.register( username, "", password)
        res.status(200).json({ registration: "success", player_id: id})
        
    }
    catch (error) {
        res.status(500).json({ error: 'Registration failed'});
    }
});

router.put("/user", (req, res) => {

});

router.delete("/user", (req, res) => {

});

router.get("/properties", (req, res) => {
    const connection = mysql.createConnection( config.db )
    connection.query("SELECT * FROM mta.properties;", (error, rows, fields) => {
        if ( error ) throw error;
        console.log("Got here");
        console.log(rows)
        res.status(200).json(rows);
    }
    
    );
});

module.exports = router