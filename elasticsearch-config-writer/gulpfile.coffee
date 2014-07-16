###*
@author Isaac Johnston <isaac.johnston@joukou.com>
@copyright 2014 Joukou Ltd. All rights reserved.
###

gulp        = require( 'gulp' )
plugins     = require( 'gulp-load-plugins' )( lazy: false )

gulp.task( 'clean', ->
  gulp.src( 'lib', read: false )
    .pipe( plugins.clean( force: true ) )
    .on( 'error', plugins.util.log )
)

gulp.task( 'coffee', [ 'clean' ], ->
  gulp.src( 'src/**/*.coffee' )
    .pipe( plugins.coffee( bare: true ) )
    .pipe( gulp.dest( 'lib' ) )
    .on( 'error', plugins.util.log )
)

gulp.task( 'build', [ 'coffee' ] )

gulp.task( 'default', [ 'build' ] )