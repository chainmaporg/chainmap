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

exports.register = function(req,res){
  // console.log("req",req.body);
  var today = new Date();
  var users={
    "email":req.body.email,
    "password":req.body.password,
    "primarycat":req.body.primarycat,
    "partneryes":req.body.partneryes,
    "teamneeds":req.body.teamneeds,
    "location":req.body.location,
    "created":today,
    "modified":today
  }
  connection.query('INSERT INTO users SET ?',users, function (error, results, fields) {
  if (error) {
    console.log("error ocurred",error);
    res.send({
      "code":400,
      "failed":"error ocurred"
    })
  }else{
    console.log('The solution is: ', results);
    //res.render('challenge', { title: 'Challenge' });
    res.redirect('challenge');
    //
    //res.send({
    //  "code":200,
    //  "success":"user registered sucessfully"
    //    });
  }
  });

}


exports.login = function(req,res){
  var email= req.body.email;
  var password = req.body.password.trim();
  connection.query('SELECT * FROM users WHERE email = ?',[email], function (error, results, fields) {
  if (error) {
    // console.log("error ocurred",error);
    res.send({
      "code":400,
      "failed":"error ocurred"
    })
  }else{
    console.log('The solution is: ', results);
    console.log('[0]=',[0]);
    if(results.length >0){
      if(results[0].password == password){
        //res.render('challenge', { title: 'Challenge' });
        
        res.redirect('challenge');
        
        //res.send({
        //  "code":200,
        //  "success":"login sucessfull"
        //    });
      }
      else{
        console.log("password=",password);
        res.send({
          "code":204,
          "success":"Email and password does not match"
            });
      }
    }
    else{
      res.send({
        "code":204,
        "success":"Email does not exits"
          });
    }
  }
  });
}

