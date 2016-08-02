class Driver < ActiveRecord::Base
  belongs_to :tenant
  has_many :daily_scores

  validates :license_id, presence: true
  validates_presence_of :tenant_id

  def summary
    daily_scores = DailyScore.of_driver_id(id)
    scores = daily_scores.pluck(:driving_date, :score, :max_score)
    scores.map!{|dd, s, ms| [dd.utc.beginning_of_day.strftime('%s').to_i*1000, s.to_f/ms.to_f]}
  end
end