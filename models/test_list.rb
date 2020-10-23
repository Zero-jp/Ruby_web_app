# frozen_string_literal: true

require 'forwardable'

# The list of test to manage
class TestList
  extend Forwardable
  def_delegator :@tests, :each, :each_tests # Method 'each' must be adopted to 'tests' as method 'each_tests'

  def initialize(tests = [])
    @tests = tests
  end
end
