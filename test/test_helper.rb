require "bundler/setup"

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'minitest/autorun'
require 'active_support/all'
require 'action_view'
require 'smart_titles'

I18n.enforce_available_locales = true
ActiveSupport.test_order = :random
