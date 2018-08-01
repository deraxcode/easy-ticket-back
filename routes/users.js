var express = require('express');
var router = express.Router();
var app = require("../app");
var User = require("../model/User");
const consts = require("../util/consts")

router.post("/assistant", function(req, res) {

    let user = req.body;

    user['user_status_id'] = consts.USER_INACTIVE;
    user['google'] = false;

    console.log(user);

    let userDAO = new User(req.app.get('db'));

    let savedUser = userDAO.save(user);

    res.send(savedUser);

});

router.post("/host", function(req, res) {

    let user = req.body;


    console.log(user);

    var userDAO = new User(app.get('db'));

    let savedUser = userDAO.save(user);

    res.send(savedUser);

});

module.exports = router;