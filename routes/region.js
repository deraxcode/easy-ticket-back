var express = require('express');
var router = express.Router();
const { check, validationResult } = require('express-validator/check');
const Region = require('../model/Region');
const Response = require('../domain/response');
const consts = require("../util/consts")

router.get("/:regionId?", [
    check('regionId')
        .optional()
        .isInt().withMessage('Provide a correct value'),
], async function (req, res) {

    var responseObject = new Response();

    try {
        var errors = validationResult(req);
        if (!errors.isEmpty()) {
            console.log(errors.mapped());
            responseObject.errors.code = consts.VALIDATION_ERROR_CODE;
            responseObject.errors.message = errors.mapped();
            return res.json(responseObject);
        }

        var regionId = req.params.regionId;
        var regionDao = new Region(req.app.get('db'));
        var listRegions = await regionDao.getRegions(regionId);
        responseObject.data = listRegions;
        return res.json(responseObject);
    } catch (err) {
        console.log(err);
        responseObject.errors.code = err.code;
        responseObject.errors.message = err.message;
        return res.json(responseObject);
    }

});

router.get("/communes/:regionId", [
    check('regionId')
        .exists()
        .isInt().withMessage('Provide a correct value'),
], async function (req, res) {

    var responseObject = new Response();

    try {
        var errors = validationResult(req);
        if (!errors.isEmpty()) {
            console.log(errors.mapped());
            responseObject.errors.code = consts.VALIDATION_ERROR_CODE;
            responseObject.errors.message = errors.mapped();
            return res.json(responseObject);
        }

        let regionId = req.params.regionId;
        console.log(regionId);
        var regionDao = new Region(req.app.get('db'));
        var listCommunes = await regionDao.getCommunesByRegion(regionId);
        responseObject.data = listCommunes;
        return res.json(responseObject);

    } catch (err) {
        console.log(err);
        responseObject.errors.code = err.code;
        responseObject.errors.message = err.message;
        return res.json(responseObject);
    }

});

module.exports = router;