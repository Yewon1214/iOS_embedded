var mongoose = require('mongoose');

mongoose.connect('mongodb://localhost:27017/crawl_datas');

var db = mongoose.connection;

// 4. 연결 실패
db.on('error', function(){
	console.log('Connection Failed!');
});

// 5. 연결 성공
db.once('open', function() {
	console.log('Connected!');
});

var data = mongoose.Schema({
	title : String, //제목
    date: String, //날짜
    question : String, //질문
    answer : [String]  //답변
});

var Data = mongoose.model('Data', data);

var newData = new Data({title:'질문',date: '2021/09/18', image: '어쩌구', question:'질문내용', answer:['1번질문', '2번질문']});

newData.save(function(error, data){
    if(error){
        console.log(error);
    }else{
        console.log('Saved!')
    }
});