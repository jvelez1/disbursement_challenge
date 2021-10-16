# hello-scheduler.rb

require 'sidekiq-scheduler'

class HelloWorldWorker
  include Sidekiq::Worker

  def perform
    puts 'Hello world'
  end
end

