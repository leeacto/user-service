# Welcome to Belly User Service

This Rack app is a small service to be used in conjunction with Belly's Check-In code challenge. The primary function is to create and retrieve users from a database.

## Requirements
User Service runs on Ruby 2.0.0-p247. Please install with your favorite version manager.

## Installation
* Clone User Service from [here](https://github.com/leeacto/user-service)
* Run <code>bundle install</code>
* Run <code>rake db:create; RACK_ENV=test rake db:create</code> to create the database
* Run <code>rake db:migrate; RACK_ENV=test rake db:migrate</code> to create tables

## Usage
User Service provides API endpoints to create and update users (resource name: users)
The service can be run on port 9393 with <code>shotgun -p 9393</code>
Use <code>rake routes</code> to view the available endpoints

