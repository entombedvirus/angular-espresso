'use strict'

path = require 'path'

module.exports = (grunt) ->
	# load all grunt tasks
	require('matchdep').filterDev('grunt-*').forEach grunt.loadNpmTasks

	appConfig =
		root: path.resolve(__dirname)
		app: path.resolve(__dirname + '/app')
		tmp: path.resolve(__dirname + '/.tmp')
		dist: path.resolve(__dirname + '/dist')

	grunt.initConfig
		config: appConfig
		clean:
			all:
				src: [
					appConfig.tmp
					appConfig.dist
				]

		copy:
			client:
				files: [
						expand: true
						dot: true
						cwd: appConfig.root + '/app'
						src: ['angular/**']
						dest: appConfig.tmp + '/public'
				,
						expand: true
						dot: true
						cwd: appConfig.root
						src: ['public/**']
						dest: appConfig.tmp
				]
			server:
				files: [
						expand: true
						dot: true
						cwd: appConfig.root
						src: ['app/**', '!app/angular/**']
						dest: appConfig.tmp
				]

		coffee:
			client:
				options:
					sourceMap: true
				files: [
					expand: true
					cwd: appConfig.tmp
					src: 'public/angular/{,*/}*.coffee'
					dest: appConfig.tmp
					ext: '.js'
				]
			server:
				options:
					sourceMap: true
				files: [
					expand: true
					cwd: appConfig.tmp
					src: 'app/{,*/}*.coffee'
					dest: appConfig.tmp
					ext: '.js'
				]

		watch:
			options:
				nospawn: true
			server:
				files: [appConfig.app + "/**/*.{coffee,js}", "!**/angular/**"]
				tasks: ['copy:server', 'coffee:server']
			client:
				files: [appConfig.app + "/angular/{,*/}*.{coffee,js}"]
				tasks: ['copy:client', 'coffee:client']

		nodemon:
			dev:
				options:
					file: path.join appConfig.tmp, 'app', 'index.js'
					watchedFolders: [appConfig.tmp + '/app']
					debug: true
					delay: 1

		concurrent:
			dev:
				tasks: ['nodemon', 'watch']
				options:
					logConcurrentOutput: true

	grunt.registerTask 'build', ['copy', 'coffee']
	grunt.registerTask 'dev', ['clean', 'build', 'concurrent:dev']

	grunt.registerTask 'default', ['dev']
