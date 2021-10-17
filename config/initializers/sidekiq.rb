# frozen_string_literal: true
require 'sidekiq'
require 'sidekiq-scheduler'


REDIS_CONFIG = Rails.application.config_for(:redis)

Sidekiq.configure_server do |config|
	config.on(:startup) do
    schedule_all_envs_file = File.expand_path('../sidekiq.yml', __dir__)
		schedule = YAML.load_file(schedule_all_envs_file)[:schedule]
		Sidekiq.schedule = schedule
		SidekiqScheduler::Scheduler.instance.reload_schedule!
  end

  config.redis = REDIS_CONFIG
end

Sidekiq.configure_client do |config|
  config.redis = REDIS_CONFIG
end
