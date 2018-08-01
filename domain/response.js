class Response {

    constructor(){
        this.data = [];
        this.errors = {
            code: 0,
            relate: "",
            message: ""
        };
    }
}

module.exports = Response;