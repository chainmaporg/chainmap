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


router.get('/query/:category/:content', function(req, res, next) {
  console.log("category " + req.params.category);
  var url = '';
	// http://localhost:8983/solr/chainmap/select?fl=title&q=content:bitcoin&start=10
  if (req.params.category == 'All') {
    url = 'http://localhost:8983/solr/chainmap/select?fl=title,%20summary,%20category&q=search_content:'+ encodeURI(req.params.content) +'&wt=json';
  } else {
    url = 'http://localhost:8983/solr/chainmap/select?fl=title,%20summary,%20category&q=category:'+ encodeURI(req.params.category) + '%20AND%20search_content:'+ encodeURI(req.params.content) +'&wt=json';
  }
  // console.log(url);
  
	console.log('query is ' + url);
  	client.get(url, function (data, response) {
    	var obj = JSON.parse(data);
    	res.send(obj);
	});
});


router.get('/results/:content', function(req, res, next) {
  //http://localhost:8983/solr/chainmap/select?fl=title&q=content:bitcoin&start=10

  // var url = 'http://localhost:8983/solr/chainmap/select?fl=title,%20summary&q=search_content:'+ encodeURI(req.params.content) +'&wt=json';
  var url = 'http://localhost:8983/solr/chainmap/select?q=company:%20EncryptoTel&wt=json';
  console.log('query is ' + url);
    client.get(url, function (data, response) {
      var obj = JSON.parse(data);

      res.render('search_result', {docs: obj.response.docs});
  });
});

router.get('/resource/company/:name', function(req, res) {
  //http://localhost:8983/solr/chainmap/select?q=Company:%20EncryptoTel
  var url = 'http://localhost:8983/solr/chainmap/select?q=company:%20' + encodeURI(req.params.name) +'&wt=json';
  console.log('query is ' + url);
    client.get(url, function (data, response) {
      var obj = JSON.parse(data);
      // res.send(obj);
      res.render('company', {
        company: obj.response.docs[0].company,
        company_url: obj.response.docs[0].company_url,
        ceo: obj.response.docs[0].ceo,
        company_email: obj.response.docs[0].company_mail,
        company_twitter: obj.response.docs[0].company_twitter,
        CEO_Twitter: obj.response.docs[0].ceo_twitter,
        company_blog: obj.response.docs[0].company_blog
        // company: req.params.name
      });
  });
    // res.render('company', { title: 'Comapany Info' });
});

router.get('/resource/ico/:name', function(req, res) {
  // http://localhost:8983/solr/chainmap/select?q=ico_name:21%20million
  var url = 'http://localhost:8983/solr/chainmap/select?q=ico_name:%20' + encodeURI(req.params.name) +'&wt=json';
  console.log('query is ' + url);
    client.get(url, function (data, response) {
      var obj = JSON.parse(data);
      // res.send(obj);
      res.render('ico', {
        ico: obj.response.docs[0].ico_name,
        ico_url: obj.response.docs[0].url,
        twitter: obj.response.docs[0].twitter,
        email: obj.response.docs[0].email,
        blog: obj.response.docs[0].blog,
        ceo: obj.response.docs[0].ceo,
        ceo_twitter: obj.response.docs[0].ceo_twitter,
        ceo_mail: obj.response.docs[0].ceo_mail
        // company: req.params.name
      });
  });
    // res.render('company', { title: 'Comapany Info' });
});

router.get('/resource/event/:name', function(req, res) {
  // http://localhost:8983/solr/chainmap/select?q=event_name:%22Peer%20Summit%22
  var url = 'http://localhost:8983/solr/chainmap/select?q=event_name:%20' + encodeURI(req.params.name) +'&wt=json';
  console.log('query is ' + url);
    client.get(url, function (data, response) {
      var obj = JSON.parse(data);
      // res.send(obj);
      res.render('event', {
        event: obj.response.docs[0].event_name,
        event_url: obj.response.docs[0].event_url,
        event_date: obj.response.docs[0].event_date,
        event_city: obj.response.docs[0].event_city,
        event_country: obj.response.docs[0].event_country,
        event_twitter: obj.response.docs[0].event_twitter,
        contact_url: obj.response.docs[0].event_contact_url,
        email: obj.response.docs[0].event_mail
        // company: req.params.name
      });
  });
    // res.render('company', { title: 'Comapany Info' });
});

router.get('/resource/white_paper/:name', function (req, res, next) {

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
