var gulp = require('gulp');
var path = require('path');

var debug = require('gulp-debug');
var gutil = require('gulp-util');

var uglify = require('gulp-uglify'); // Минификация JS
var concat = require('gulp-concat'); // Склейка файлов

var base64 = require('gulp-base64');
var less = require('gulp-less');
var csso = require('gulp-csso');
var svgmin = require('gulp-svgmin');


var data_uri = require('gulp-data-uri');
var bower = require('main-bower-files');


var pleeease = require('gulp-pleeease');

var clean = require('gulp-clean');



var inlineCss = require('gulp-inline-css');
var inlinesource = require('gulp-inline-source');
var htmlmin = require('gulp-htmlmin');

var minifyHTML = require('gulp-minify-html');

//var del = require('del');
//var sourcemaps = require('gulp-sourcemaps');


var pth = './assets';
var paths = {

    assets: pth,
    svg_in: pth + '/svg/*.svg',
    svg_out: pth + '/svg',
    img: pth + '/img',
    less: pth + '/less/all.less',
    js: pth + '/js',
    vendor: pth + '/js/vendor/**/*.js',
    email:'./email/*.html',
    email_compile:'./email/compile',
    scripts: [
        pth + '/js/lib.js',
        pth + '/js/vendor.js',
        pth + '/js/component/*.js',
        pth + '/js/magic.js'
    ],
    clean_scripts: [
        pth + '/js/vendor.js'
    ]
};





//.pipe(pleeease({browsers: ['IE 9', 'last 3 versions', 'Android 2.3']}))
//.pipe(pleeease({browsers: ['Opera 12', 'last 2 versions', 'Android 2.3']}))



gulp.task('css', function () {
    gulp
        .src(paths.less)
        .pipe(debug())
        .pipe(less({paths: [path.join(__dirname, 'less', 'includes')]}))
        //.pipe(data_uri())
        .pipe(base64({debug: true}))
        .pipe(csso())
        .pipe(pleeease({browsers: ['last 2 versions', 'Android 2.3']}))
        .pipe(gulp.dest(paths.assets))
        .on('error', gutil.log);
});




gulp.task('js', function () {

    return gulp
        .src(paths.scripts)
        .pipe(debug())
        .pipe(concat('all.js'))
        .pipe(uglify())
        .pipe(gulp.dest(paths.assets))
        .on('error', gutil.log);
});


gulp.task('_js', function () {

    var nm = 'photo_swipe';

    return gulp
        .src(nm + '/src/js/**/*.js')
        .pipe(debug())
        .pipe(concat(nm + '.js'))
        .pipe(uglify())
        .pipe(gulp.dest(paths.assets + '/js/component'))
        .on('error', gutil.log);
});


gulp.task('bower', function () {

    return gulp
        .src(bower({debugging: true}))
        .pipe(concat('lib.js'))
        .pipe(uglify())
        .pipe(gulp.dest(paths.js))
        .on('error', gutil.log);

});

//gulp.task('vendor', ['clean-scripts'], function () {

gulp.task('vendor', function () {

    return gulp
        .src(paths.vendor)
        .pipe(debug())
        .pipe(concat('vendor.js'))
        .pipe(uglify())
        .pipe(gulp.dest(paths.js))
        .on('error', gutil.log);

});




gulp.task('img', function () {
    return gulp
        .src(paths.svg_in)
        .pipe(svgmin())
        .pipe(gulp.dest(paths.svg_out))
        .on('error', gutil.log);
});


//gulp.task('clean', function (cb) {
//    // You can use multiple globbing patterns as you would with `gulp.src`
//   del(['css', 'js', 'vendor'], cb);
//});


gulp.task('clean-scripts', function () {
    return gulp.src(paths.clean_scripts, {read: false})
        .pipe(clean());
});


gulp.task('default', ['css', 'js']);
