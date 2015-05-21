FactoryGirl.define do
  factory :reservation do
    sequence(:id)         { |n| "#{n}" }
    sequence(:table_id)   { |n| rand(1..10) }
    sequence(:start_time) { |n| Time.now }
    sequence(:end_time)   { |n| Time.now + 1.hour }
  end
end