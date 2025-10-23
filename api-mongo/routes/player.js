const express = require("express");
const router = express.Router();
const Player = require('../models/player')

router.get("/", async (req, res) => {
    try {
        const players = await Player.find({});
        res.status(200).json(players);
    } catch (error) {
        res.status(500).json({message: error.message});
    }
});

// Get Player By ID
router.get("/:id", async (req, res) => {
    try {
        const players = await Player.findById(req.params.id);
        res.status(200).json(players);
    } catch (error) {
        res.status(500).json({message: error.message});
    }
});

// Register
router.post("/", async (req, res) => {
    try {
        const player = await Player.create(req.body);
        res.status(200).json(player)
    } catch (error) {
        res.status(500).json({message: error.message})
    }
});

// Login
router.post("/login", async (req, res) => {
    try {
        console.log(req)
        const player = await Player.find({"username": req.body.username, "password": req.body.password } )
        res.status(200).json(player)
    }
    catch (error) {
        console.log(req.body)
        res.status(500).json({message: error.message})
    }
});

module.exports = router;