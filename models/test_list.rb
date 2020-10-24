# frozen_string_literal: true

require 'forwardable'

# The list of test to manage
class TestList
  extend Forwardable
  def_delegator :@tests, :each, :each_test # Method 'each' must be adopted to 'tests' as method 'each_tests'

  def initialize(tests = [])
    @tests = tests
  end

  # Adding new test to the list of tests
  def add_test(test)
    @tests.append(test)
  end

  def all_tests
    @tests.dup
  end

  # Filter action
  def filter(date, description)
    @tests.select do |test|
      next if !date.empty? && date != test.date
      next if !description.empty? && !test.description.include?(description)

      true
    end
  end
end
