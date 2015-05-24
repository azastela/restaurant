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

  scope :by_table, -> (table_id) { where(table_id: table_id) }

  validate :validate_time_overlapping

  def validate_time_overlapping
  	reservations = Reservation.where("start_time <= :end_time AND :start_time <= end_time AND table_id = :table_id AND id NOT IN(:id)",
              		end_time: end_time, start_time: start_time, table_id: table_id, id: id.present? ? id : 0)

  	errors.add :start_time, :time_overlapped if reservations.size > 0
  end

  TABLES_COUNT = 4.freeze
end
