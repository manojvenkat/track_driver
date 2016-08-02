namespace :db do
  desc 'Generate the event data and populate the scores for drivers of various tenants.'
  task load_seed_data: :environment do
    tenant_count = 3 #5
    vehicle_count_per_tenant = [20, 15, 10] #[100, 50, 20, 15, 15]
    num_days = 15.days/1.day
    tenant_vehicle_hash = create_tenants_and_vehicles(tenant_count, vehicle_count_per_tenant)
    values = tenant_vehicle_hash.values[0]
    values.each do |vehicle_id, driver_id|
      (1..num_days).each do |i|
        date = (Time.now.beginning_of_day) + i.days
        DailyScore.delay.generate_score(vehicle_id, driver_id, date)
      end
    end
  end

  def create_tenants_and_vehicles(tenant_count, vehicle_count_per_tenant)
    tenant_vehicle_hash = {}
    (1..tenant_count).to_a.each do |i|
      tenant = Tenant.create!(name: "tenant_#{i}", email: "tenant_#{i}@gmail.com", city: "city_#{i}")
      puts "Created Tenant: #{tenant.id}"
      tenant_vehicle_hash[tenant.id] = []
      (1..vehicle_count_per_tenant[i-1]).to_a.each do |j|
        puts "Inserted: vehicle_#{j}_tenant_#{i}"
        vehicle = tenant.vehicles.create!(registration: "vehicle_#{j}_tenant_#{i}")
        driver = tenant.drivers.create!(license_id: "driver_#{j}_tenant_#{i}")
        tenant_vehicle_hash[tenant.id] << [vehicle.id, driver.id]
      end
    end
    tenant_vehicle_hash
  end

  task delete_seed_data: :environment do
    Vehicle.destroy_all
    Tenant.destroy_all
    DailyScore.destroy_all
    User.last(6).each{|u| u.destroy!}
  end
end