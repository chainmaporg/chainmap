var mysql      = require('mysql');
var mysql      = require('mysql');

/**
var db_config = {
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'test'
};
**/

//**
var db_config = {
  host     : '107.181.170.169 ',
  user     : 'dbuser',
  password : 'telenav123',
  database : 'rsdb'
};
//**/

var connection;

function handleDisconnect() {
  // Recreate the connection, since
  connection = mysql.createConnection(db_config); 
                                                 

  connection.connect(function(err) {              
    if(err) {                                     
      console.log('error when connecting to db:', err);
      // We introduce a delay before attempting to reconnect,
      setTimeout(handleDisconnect, 2000); 
    }                                     
  });                                     
                                         
  connection.on('error', function(err) {
    console.log('db error', err);
    if(err.code === 'PROTOCOL_CONNECTION_LOST') { 
      handleDisconnect();                         
    } else {                                     
      throw err;                                 
    }
  });
}

handleDisconnect();

exports.content = function(req,res){
	console.log("dddd-content route")
	session = req.session;
	console.log("dddd-content222 route")
	if(!session.email) {
		return res.redirect("/")
	}
	
  connection.query('SELECT * FROM materials',[], function (error, results, fields) {
  if (error) {
    console.log("error ocurred",error);
    res.render("error", {errorMsg: "error on select * from materials"})

  }else{
    console.log('The solution is: ', results);
    if(results.length >0){
    	res.render('content', { data:results });
    }
  }
  });
}

