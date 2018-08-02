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
], async function (req, res, next) {

    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(consts.VALIDATION_ERROR_CODE).json({ errors: errors.array() });
        }
        var regionId = req.params.regionId;
        var regionDao = new Region(req.app.get('db'));
        var listRegions = await regionDao.getRegions(regionId).catch(err=>{ throw err;});
        return res.json(listRegions);
    } catch (err) {
        console.log(err);
        res.status(consts.SERVER_ERROR_CODE).send();
    }

});

router.get("/:regionId/communes", [
    check('regionId')
        .exists()
        .isInt().withMessage('Provide a correct value'),
], async function (req, res, next) {    

    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(consts.VALIDATION_ERROR_CODE).json({ errors: errors.array() });
        }
        let regionId = req.params.regionId;        
        var regionDao = new Region(req.app.get('db'));
        var listCommunes = await regionDao.getCommunesByRegion(regionId).catch(err=>{ throw err;});        
        return res.json(listCommunes);

    } catch (err) {
        console.log('error : ' + err);        
        res.status(consts.SERVER_ERROR_CODE).send();
    }

});

module.exports = router;