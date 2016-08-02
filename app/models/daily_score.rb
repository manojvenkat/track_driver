class DailyScore < ActiveRecord::Base
  validates_presence_of :driver_id, :vehicle_id, :score, :driving_date
  # validates_uniqueness_of [:driver_id, :vehicle_id, :date], on: :create
  belongs_to :driver
  belongs_to :vehicle

  scope :of_driver_id, ->(driver_id) { where(driver_id: driver_id) }

  module EventProbability
    RED = 0.1
    GREEN = 0.7
    YELLOW = 0.2
  end

  module EventType
    RED = "RED"
    GREEN = "GREEN"
    YELLOW = "YELLOW"
  end

  class << self
    def generate_score(vehicle_id, driver_id, date)
      file = open("test_data/#{vehicle_id}_#{driver_id}_#{date}.csv", 'w')
      file_string = ''
      time = Time.now
      clocking_time = date.beginning_of_day
      run_time = 10.hours/1.minute
      if flip_a_coin
        num_minutes = 12.hours/1.minute
      else
        num_minutes = 13.hours/1.minute
      end
      event_prob = run_time.to_f/num_minutes.to_f
      start_time = clocking_time
      daily_score_record = find_or_create(vehicle_id, driver_id, start_time)
      score = daily_score_record.score
      (1..num_minutes).each do |min|
        start_time = clocking_time
        end_time = clocking_time = clocking_time + 1.minute
        rand_float = generate_rand_float
        if rand_float <= event_prob
          event = generate_event(start_time, end_time, vehicle_id, driver_id)
          score = process_event(event, score)
          file_string += "#{vehicle_id}, #{driver_id}, #{start_time}, #{end_time}, #{event[:event]}, #{event[:driver_mistake]}\n"
        end
      end
      daily_score_record.update_attributes!(score: score, max_score: num_minutes)
      file.write(file_string)
      file.close
    end

    def generate_event(start_time, end_time, vehicle_id, driver_id)
      rand_float = generate_rand_float
      event_hash = {start_time: start_time, end_time: end_time, vehicle_id: vehicle_id, driver_id: driver_id}
      if rand_float <= EventProbability::RED
        return event_hash.merge({event: EventType::RED, driver_mistake: flip_a_coin})
      elsif rand_float > EventProbability::RED and rand_float <= (EventProbability::GREEN + EventProbability::RED)
        return event_hash.merge({event: EventType::GREEN, driver_mistake: nil})
      else
        return event_hash.merge({event: EventType::YELLOW, driver_mistake: flip_a_coin})
      end
    end

    def process_event(event, current_score)
      case event[:event]
      when EventType::RED
        if event[:driver_mistake]
          current_score *= 0.9
        else
          current_score += 100
        end
      when EventType::GREEN
        current_score += 1
      when EventType::YELLOW
        if event[:driver_mistake]
          current_score *= 0.98
        else
          current_score += 10
        end
      end
      current_score
    end

    def generate_rand_float
      Random.rand(1000000).to_f/(1000000.to_f)
    end

    def flip_a_coin
      (generate_rand_float > 0.5) ? true : false
    end

    def find_or_create(vehicle_id, driver_id, date)
      ds = DailyScore.where(vehicle_id: vehicle_id, driver_id: driver_id).where(driving_date: date.beginning_of_day).first
      unless ds.present?
        ds = DailyScore.create!(vehicle_id: vehicle_id, driver_id: driver_id, driving_date: date.beginning_of_day, score: 0)
      end
      ds
    end
  end
end