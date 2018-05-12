var express = require('express');
var SolrNode = require('solr-node');
var router = express.Router();


// var client = new SolrNode({
//     host: 'localhost',
//     port: '8983',
//     core: 'chainmap',
//     protocol: 'http',
//     debugLevel: 'ERROR' // log4js debug level paramter 
// });

var Client = require('node-rest-client').Client;
 
var client = new Client();


// var strQuery = client.query().q('text:test');
// var objQuery = client.query().q({text:'test', title:'test'});
// var myStrQuery = 'q=text:test&wt=json';


// router.get('/whitepaper', function(req, res, next) {
//   // var query = client.query().q('content:bitcoin');
//   var query = 'q=content:bitcoin&fl=title&rows=20&start=10&wt=json';
//   client.search(query, function(err, obj) {
//   	if(err) {
//   		res.send(err);
//   	} else {
//   		// res.json(obj);
//   		res.render('results', {
//   			numFound: obj.response.numFound,
//   			docs: obj.response.docs
//   		});
//   	}
  
//   });
// });

router.get('/query/:content', function(req, res, next) {
	//http://localhost:8983/solr/chainmap/select?fl=title&q=content:bitcoin&start=10

	var url = 'http://localhost:8983/solr/chainmap/select?fl=title&q=content:'+ encodeURI(req.params.content) +'&wt=json';
	console.log('query is ' + url);
  	client.get(url, function (data, response) {
  		// res.send(data);
    	// parsed response body as js object 
    	var obj = JSON.parse(data);
    	// console.log(obj);
    	res.send(obj);
    	// raw response 
    	// console.log(response);
	});
});

router.get('/resource/whitepaper/:name', function (req, res, next) {

/**
	session = req.session;
	if(!session.email) {
		res.redirect("/")
	}
**/	
  var options = {
    // root: __dirname + '/resources/whitepaper/',
    root: './resources/whitepaper/',
    dotfiles: 'deny',
    headers: {
        'x-timestamp': Date.now(),
        'x-sent': true
    }
  };

  var fileName = req.params.name;
  res.sendFile(fileName, options, function (err) {
    if (err) {
      console.log(err);
      res.status(err.status).end();
    }
    else {
      console.log('Sent:', fileName);
    }
  });

});

// router.get('/search/:content', function(req, res, next) {
//   // var query = 'q=content:房地产&fl=title&rows=20&start=10&wt=json';
//   // res.writeHead(200, {'Content-Type': 'text/plain;charset=utf-8'});
//   var query = 'q=content:' + req.params.content + '&fl=title&rows=20&start=10&wt=json';
//   console.log('query is ' + query);
//   client.search(query, function(err, obj) {
//   	if(err) {
//   		res.send("ERROR");
//   	} else {
//   		res.send(obj);
//   	}
  
//   });
// });

router.get('/page', function(req, res) {
    res.render('home', { title: 'Home' });
});

router.get('/about', function(req, res) {
    res.render('about', { title: 'About' });
});

router.get('/signup', function(req, res) {
    res.render('signup', { title: 'Signup' });
});

router.get('/login', function(req, res) {
    res.render('login', { title: 'Login' });
});


router.get('/partnerevent', function(req, res) {
    res.render('partnerevent', { title: 'Partner events and news' });
});


//route to handle user registration
var login = require('../routes/login');
var content = require('../routes/content');
var challenge = require('../routes/challenge');
router.get('/register', login.register)
router.post('/register', login.register)
router.post('/login',login.login)

router.get('/logout',function(req,res){
	req.session.destroy(function(err) {
  	if(err) {
    	console.log(err);
 	 } else {
  	  res.redirect('/');
 	 }
	});
})

router.get('/content',content.content)
router.get('/challenge',challenge.challenge)
router.get('/signup', function(req, res) {
    res.render('signup', { title: 'Sign up' });
});
router.get('/', function(req, res) {
    res.render('home', { title: 'Home' });
});





/* GET home page. */
router.get('/search', function(req, res, next) {
	/**ddd
	session = req.session;
	if(!session.email) {
		return res.redirect("/")
	}
	**/
	
  res.render('search', { title: 'Whitepaper etc' });
});

module.exports = router;
