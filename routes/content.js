var mysql      = require('mysql');
/**
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : '',
  database : 'test'
});
**/

var connection = mysql.createConnection({
  host     : '107.181.170.169 ',
  user     : 'dbuser',
  password : 'telenav123',
  database : 'rsdb'
});

connection.connect(function(err){
if(!err) {
    console.log("Database is connected ... nn");
} else {
    console.log("Error connecting database ... nn");
}
});


exports.content = function(req,res){
  console.log("dddd1111................")
  connection.query('SELECT * FROM materials',[], function (error, results, fields) {
  if (error) {
    console.log("error ocurred",error);
    res.send({
      "code":400,
      "failed":"error ocurred"
    })
  }else{
    console.log('The solution is: ', results);
    if(results.length >0){
    	res.render('content', { data:results });
    }
  }
  });
}

