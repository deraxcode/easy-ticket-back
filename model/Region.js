class Region {
    constructor(db) {
        this.db = db;
    }

    getRegions(regionId) {
        var db = this.db;
        return new Promise(function (resolve, reject) {
            if (regionId) {
                db.region.findOne({ region_id: regionId })
                    .then(result => {
                        resolve(result);
                    })
                    .catch(err => {
                        reject(err);
                    });
            } else {
                db.region.find()
                    .then(result => {
                        resolve(result);
                    })
                    .catch(err => {
                        reject(err);
                    });;
            }
        });
    }


    getCommunesByRegion(regionId) {
        var db = this.db;
        return new Promise(function (resolve, reject) {
            var query = `SELECT c.commune_id, c."name", c.province_id, p."name" as province_name
                         FROM commune c
                         inner join province p on c.province_id = p.province_id and p.region_id = $1`;
            db.query(query, [regionId])
                .then(result => {
                    resolve(result);
                })
                .catch(err => {
                    reject(err);
                });
        });
    }
}

module.exports = Region;