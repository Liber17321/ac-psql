require_relative '../config/environment'
Rails.application.eager_load!
ActionCable.server.config.logger = Logger.new STDOUT

run ActionCable.server