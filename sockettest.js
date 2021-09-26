const express = require('express'); 
const app = express();
const http = require('http').Server(app); 
const io = require('socket.io')(http); 
app.use(express.urlencoded({extended: false}))
app.use(express.json())

var request = require('request');

http.listen(9000, function () { 
    console.log('Listening on *:9000'); 
});

var mongoose = require('mongoose');

mongoose.connect('mongodb://localhost:27017/crawl_datas');

var db = mongoose.connection;

db.on('error', function(){
	console.log('Connection Failed!');
});

db.once('open', function() {
	console.log('Connected!');
});

var dataSchema = mongoose.Schema({
	title : String, //제목
    question : String, //질문
    answer : [String]  //답변
});

var Data = mongoose.model('Data', dataSchema);
var report = new Object();

app.post('/accident', function(req, res){
    console.log(req.body.alarm);
    report.mapX = req.body.mapX;
    report.mapY = req.body.mapY;
    io.emit("accident", "true");
});

io.on('connection', (socket) => { 
    console.log('*** test connected ***'); 
    console.log(socket.id) 

    socket.on('disconnect', function () { 
        socket.disconnect(); 
        console.log('test disconnected'); 
    }); 

    socket.on('loginSuccess', function(data){
        console.log(data)
        var str = data.split('/');
        report.userid=str[0];
        report.carType=str[1];
        report.carNum=str[2];
        console.log(report);
    })
    
    socket.on('report', function(data){
        console.log('report')
        console.log(report)
        request.post({
            headers: {'content-type': 'application/json'},
            url: 'http://223.131.2.220:1818/report',
            body: report,
            json: true
        }, function(error, response, body){
            console.log(body)
        });

    });

    socket.on('community_init1', function(data){
        console.log('community_init1');
 
        Data.find({$or:[
            {title: {$regex: data}},
            {question:{$regex: data}}
        ]}, function(err, r){
            if(err) console.log(err);
            socket.emit("community_init1", r);
        });
    });

    socket.on('community_init2', function(data){
        console.log('community_init2');
 
        Data.find({$or:[
            {title: {$regex: data}},
            {question:{$regex: data}}
        ]}, function(err, r){
            if(err) console.log(err);
            socket.emit("community_init2", r);
        });
    });

    socket.on('community_init3', function(data){
        console.log('community_init3');
 
        Data.find({$or:[
            {title: {$regex: data}},
            {question:{$regex: data}}
        ]}, function(err, r){
            if(err) console.log(err);
            socket.emit("community_init3", r);
        });
    });

    socket.on('community_init4', function(data){
        console.log('community_init4');
 
        Data.find({$or:[
            {title: {$regex: data}},
            {question:{$regex: data}}
        ]}, function(err, r){
            if(err) console.log(err);
            socket.emit("community_init4", r);
        });
    });

})
