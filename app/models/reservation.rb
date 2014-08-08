class Reservation < ActiveRecord::Base
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :table_id, presence: true
  validates_datetime :start_time, after: :now
  validates_datetime :end_time, after: :start_time

  validate :times_overlap

  def times_overlap
  	reservations = Reservation.where("start_time <= :end_time AND :start_time <= end_time AND table_id = :table_id",
  		{ end_time: end_time,
  		start_time: start_time,
  		table_id: table_id })
  	
  	errors.add(:base, 'Times overlapped') if reservations.length > 0
  end
end
