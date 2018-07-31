var express = require('express');
var router = express.Router();

router.post("/assistant", function(req, res) {

    let user = req.body;

    res.send(user);

});

router.post("/host", function(req, res) {

    let user = req.body;

    res.send(user);

});

module.exports = router;