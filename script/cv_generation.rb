#!/usr/bin/env ruby

RAILS_ENV =  'development'

require File.dirname(__FILE__) + '/../config/boot'
require File.dirname(__FILE__) + '/../config/environment'

exp = GenerateCvController.new
exp.do_next
