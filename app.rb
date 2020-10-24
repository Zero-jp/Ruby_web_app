# frozen_string_literal: true

require 'roda'
# Connecting all files in the "models" directory
require_relative 'models'

# Core class
class App < Roda
  # Specifying the path to the root of the application
  opts[:root] = __dir__ # Here it is write that the root of the app is that file
  # Allows you to customize the application depending on the environment in which it was launched
  plugin :environments
  plugin :render

  # Development environment only
  configure :development do
    # Serving static files
    plugin :public
    opts[:serve_static] = true
  end

  route do |r|
    # All requests would be processed
    r.public if opts[:serve_static]

    # Storage of all test information
    @tests = TestList.new([
                            Test.new('Лабораторная работа №1', '2020-04-05', 'Проверка знаний по языку Ruby'),
                            Test.new('Лабораторная работа №2', '2020-04-20', 'Проверка умения написать приложение на языке Ruby'),
                            Test.new('Финальный экзамен', '2020-06-20', 'Проверка всех знаний и умений')
                          ])

    r.root do
      'Hello, World!'
    end

    r.on 'tests' do
      # @some_tests = [1, 2, 15]
      # Displaying the page template inside the layout
      # locals - sending data to the template
      # view('tests', locals: { data: 'Данные из контроллера' })

      @params = InputValidators.chek_date_description(r.params['date'], r.params['description']) # params - hash
      # Add filter
      @filtered_tests = if @params[:errors].empty?
                          @tests.filter(@params[:date], @params[:description])
                        else
                          @tests.all_tests
                        end
      view('tests')
    end
  end
end
