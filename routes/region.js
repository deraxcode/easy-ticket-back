var express = require('express');
var router = express.Router();
const Region = require('../model/Region');

router.get("/:regionId?", async function(req, res, next) {
    let regionId = req.params.regionId;
    console.log(regionId);
    var regionDao = new Region(req.app.get('db'));    
    var listRegions = await regionDao.getRegions(regionId);
    return res.json(listRegions);

});

router.get("/communes/:regionId", async function(req, res) {

    let regionId = req.params.regionId;
    console.log(regionId);
    var regionDao = new Region(req.app.get('db'));    
    var listCommunes = await regionDao.getCommunesByRegion(regionId);
    return res.json(listCommunes);

});

module.exports = router;