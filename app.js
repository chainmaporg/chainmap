var createError = require('http-errors');
var express = require('express');
var session = require('express-session');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');

var app = express();

// app.set('view engine', 'pug');
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(session({secret: 'chainmapsecret'}));
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use(express.static('image'));

app.use('/', indexRouter);
app.use('/users', usersRouter);

// catch 404 and forward to error handler
/**
app.use(function(req, res, next) {
  next(createError(404));
});
**/
// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  console.log("app:error -", err.message)
  //res.locals.error = req.app.get('env') === 'development' ? err : {};
 res.locals.error = err

  // render the error page
  res.status(err.status || 500);
  res.render('error', {errorMsg: err});
});

module.exports = app;
