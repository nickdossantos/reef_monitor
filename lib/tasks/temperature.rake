namespace :temperature do
  desc "TODO"
  task record_temperature: :environment do    
    User.includes(:tanks).all.each do |user|
      user.tanks.each do |tank|
        if tank.has_temp_sensor_configured? && user.has_api_configured?
          TemperatureService.record_temperature_from_pi(user, tank)
        end
      end
    end
  end
end
