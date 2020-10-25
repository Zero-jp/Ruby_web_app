# frozen_string_literal: true

require 'forme'
require 'roda'
# Connecting all files in the "models" directory
require_relative 'models'

# Core class
class App < Roda
  # Specifying the path to the root of the application
  opts[:root] = __dir__ # Here it is write that the root of the app is that file
  # Allows you to customize the application depending on the environment in which it was launched
  plugin :environments
  plugin :forme
  plugin :render

  # Development environment only
  configure :development do
    # Serving static files
    plugin :public
    opts[:serve_static] = true
  end

  # Storage of all test information
  opts[:tests] = TestList.new([
                                Test.new('Лабораторная работа №1', '2020-04-05', 'Проверка знаний по языку Ruby'),
                                Test.new('Лабораторная работа №2', '2020-04-20', 'Проверка умения написать приложение на языке Ruby'),
                                Test.new('Финальный экзамен', '2020-06-20', 'Проверка всех знаний и умений')
                              ])

  route do |r|
    # All requests would be processed
    r.public if opts[:serve_static]

    r.root do
      'Hello, World!'
    end

    r.on 'tests' do
      # @some_tests = [1, 2, 15]
      # Displaying the page template inside the layout
      # locals - sending data to the template
      # view('tests', locals: { data: 'Данные из контроллера' })

      # Adressing dyrectly to 'tests'
      r.is do
        @params = TestFilterFormSchema.call(r.params)
        # Add filter
        @filtered_tests = if @params.success?
                            opts[:tests].filter(@params[:date], @params[:description])
                          else
                            opts[:tests].all_tests
                          end
        view('tests')
      end

      # Adressing to 'tests/new'
      r.on 'new' do
        r.get do
          view('new_test')
        end

        r.post do
          @params = InputValidators.check_test(r.params['name'], r.params['date'], r.params['description'])
          if @params[:errors].empty?
            # Adding new test
            opts[:tests].add_test(Test.new(@params[:name], @params[:date], @params[:description]))
            r.redirect '/tests'
          else
            view('new_test')
          end
        end
      end
    end
  end
end
