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

require 'rails_helper'

RSpec.describe Reservation, :type => :model do
  expect_it{ to validate_presence_of(:table_id) }
  expect_it{ to validate_presence_of(:start_time) }
  expect_it{ to validate_presence_of(:end_time) }

  describe 'initial time validation' do
    let(:start_time){ Time.now + 1.hour }
    let(:end_time){ Time.now + 2.hours }

    subject(:reservation){ build :reservation, start_time: start_time, end_time: end_time }

    context 'when start time is in past' do
      let(:start_time){ 1.hour.ago }
      expect_it { not_to be_valid }
    end

    context 'when end time before start time' do
      let(:start_time){ Time.now + 3.hours }
      let(:end_time){ Time.now + 2.hours }
      expect_it { not_to be_valid }
    end
  end

  describe 'time overlapping validation' do
    let!(:reservation1){ create :reservation, table_id: 10 }

    subject(:reservation2){ build :reservation, table_id: 10 }

    context 'when time intersected' do
      expect_it { not_to be_valid }

      it 'adds correct error message' do
        subject.valid?
        expect(subject.errors[:base]).to include 'This table already reseved for this time'
      end
    end
  end
end
