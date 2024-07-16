const express = require("express");
const router = express.Router();

// /API

// Status
router.get("/", (req, res) => {
    res.status(200).json({status: online})
});

module.exports = router