ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require 'bundler'
Bundler.require :default, :test

require "rails/test_help"
require "minitest/rails"
require 'minitest/autorun'
require 'minitest/pride'

DatabaseCleaner.strategy = :transaction

module MiniTest
  class Spec
    class << self
      alias_method :context, :describe
    end

    before :each do
      DatabaseCleaner.start
    end

    after :each do
      DatabaseCleaner.clean
    end
  end
end

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
end
