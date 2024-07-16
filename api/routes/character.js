// /Character
const express = require("express");
const bodyParser = require('body-parser');
const router = express.Router();
const config = require("../config");
const databaseUser = require("../database/user");
const mysql = require("mysql");
const jwt = require("jsonwebtoken");


// Get Character Details
router.get("/:id", bodyParser.json(), (req, res) => {
    if( req.params.id ) {
        const connection = mysql.createConnection( config.db )
        connection.query("SELECT * FROM mta.characters WHERE id = ?;", req.params.id, (error, rows, fields) => {
            if ( error ) throw error;
            res.status(200).json(rows);
        }
        );
    }

});

// Create a character
router.post("/", bodyParser.json(), (req, res) => {
    
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