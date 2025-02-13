const express = require("express");
const app = express();

app.get("/", function(req, res) {
    return res.send("Luka Rocks server");
});

app.listen(8080, function(){
    console.log('Listening on port 8080');
});