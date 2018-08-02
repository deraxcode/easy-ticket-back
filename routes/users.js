const express = require('express');
const router = express.Router();
const app = require("../app");
const User = require("../model/User");
const consts = require("../util/consts")
const bcrypt = require("bcrypt");
const { body, check, validationResult } = require('express-validator/check');

router.post("/assistant", [
    body('first_name').isLength({ min: 1 }),
    body("last_name").isLength({ min: 1 }),
    body("email").isEmail(),
    body("password").isLength({ min: 1 }),
    body("password_confirm", "invalid password")
    .custom((value, { req }) => {
        if (value !== req.body.password) {
            // trow error if passwords do not match
            throw new Error("Passwords don't match");
        } else {
            return value;
        }
    }),
    body("birth_date").isLength({ min: 1 }),
], (req, res) => {

    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(422).json({ errors: errors.array() });
    }

    let user = req.body;

    user['user_status_id'] = consts.USER_INACTIVE;
    user['google'] = false;
    user['password'] = bcrypt.hashSync(user.password, 10);

    let userDAO = new User(req.app.get('db'));

    let savedUser = userDAO.save(user);

    res.send(savedUser);

});

router.post("/host", function(req, res) {

    let user = req.body;

    var userDAO = new User(app.get('db'));

    let savedUser = userDAO.save(user);

    res.send(savedUser);

});

module.exports = router;