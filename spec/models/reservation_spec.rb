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

  # before { @reservation = Reservation.new(start_time: "03-08-2015 16:00", end_time: "03-08-2015 18:00", table_id: 10 ) }

  # subject { @reservation }

  # it { should respond_to(:start_time)}
  # it { should respond_to(:end_time)}
  # it { should respond_to(:table_id)}

  # it { should be_valid }

  # describe "when start time is not present" do
  # 	before { @reservation.start_time = " " }
  # 	it { should_not be_valid }
  # end

  # describe "when end time is not present" do
  # 	before { @reservation.end_time = " " }
  # 	it { should_not be_valid }
  # end

  # describe "when table id is not present" do
  # 	before { @reservation.table_id = " " }
  # 	it { should_not be_valid }
  # end

  describe "when time is intersected on update" do
    let!(:other_reservation){ create :reservation, start_time: Time.now + 30.minutes }
    subject{ other_reservation }

    expect_it { not_to be_valid }

    it 'adds correct error message' do
      subject.valid?
      expect(subject.errors[:base]).to include 'This table already reseved for this time'
    end
  end


  # describe "when time is intersected on create" do

  #   before do
  #     @other_reservation = Reservation.new(start_time: "03-08-2015 17:00", end_time: "03-08-2015 18:00", table_id: 10 )
  #     @other_reservation.save
  #   end

  #   it "is invalid" do
  #     @other_reservation.should_not be_valid
  #   end

  #   it 'adds correct error message' do
  #     @other_reservation.valid?
  #     @other_reservation.errors[:base].should include "Times overlapped"
  #   end
  # end
end
