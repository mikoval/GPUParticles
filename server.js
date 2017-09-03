var express = require('express');
var app = express();
var port = process.env.PORT || 8080;



var server = app.listen(port, function() {
    console.log('Our app is running on http://localhost:' + port);
});

app.use(express.static(__dirname + '/public'));


app.get('/', function (req, res) {
  res.render('index.html')
})
app.disable('view cache');



