# == Schema Information
#
# Table name: reservations
#
#  id         :integer          not null, primary key
#  start_time :datetime
#  end_time   :datetime
#  table_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Reservation < ActiveRecord::Base
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :table_id, presence: true
  validates_datetime :start_time, after: :now
  validates_datetime :end_time, after: :start_time

  validate :validate_time_overlapping

  def validate_time_overlapping
  	reservations = Reservation.where("start_time <= :end_time AND :start_time <= end_time AND table_id = :table_id",
              		end_time: end_time, start_time: start_time, table_id: table_id)

  	errors.add(:base, 'This table already reseved for this time') if reservations.size > 0
  end

  TABLES_COUNT = 10.freeze
end
