class User {

    constructor(db) {
        this.db = db;
    }

    save(user) {
        this.db.user_assistant.save(user, function(err, result) {
            console.log(result);
        });

    }

}

module.exports = User;