ENV["RACK_ENV"] = "test"

require 'bundler'
Bundler.require :default, :test

require 'minitest/autorun'
require 'minitest/pride'

module MiniTest
  class Spec
    class << self
      alias_method :context, :describe
    end
  end

  class Unit::TestCase
    alias_method :_original_run, :run
    def run(*args, &block)
      result = nil
      Sequel::Model.db.transaction(:rollback => :always, :auto_savepoint=>true) do
        result = _original_run(*args, &block)
      end
      result
    end
  end
end
