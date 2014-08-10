require 'rails_helper'

RSpec.describe Reservation, :type => :model do
  before { @reservation = Reservation.new(start_time: "03-08-2015 16:00", end_time: "03-08-2015 18:00", table_id: 10 ) }

  subject { @reservation }

  it { should respond_to(:start_time)}
  it { should respond_to(:end_time)}
  it { should respond_to(:table_id)}

  it { should be_valid }

  describe "when start time is not present" do
  	before { @reservation.start_time = " " }
  	it { should_not be_valid }
  end

  describe "when end time is not present" do
  	before { @reservation.end_time = " " }
  	it { should_not be_valid }
  end
  
  describe "when table id is not present" do
  	before { @reservation.table_id = " " }
  	it { should_not be_valid }
  end

  describe "when there is time overlap on update" do
    before do
      @other_reservation = Reservation.new(start_time: "03-08-2015 14:00", end_time: "03-08-2015 16:00", table_id: 10 )
      @other_reservation.save
      @reservation.start_time = "03-08-2015 15:00"
    end

    it { should_not be_valid }

    it 'adds correct error message' do
      @reservation.valid?
      @reservation.errors[:base].should include "Times overlapped"
    end
  end


  describe "when there is reservation overlap on create" do

    before do
      @other_reservation = Reservation.new(start_time: "03-08-2015 17:00", end_time: "03-08-2015 18:00", table_id: 10 )
      @other_reservation.save
    end

    it "is invalid" do
      @other_reservation.should_not be_valid
    end

    it 'adds correct error message' do
      @other_reservation.valid?
      @other_reservation.errors[:base].should include "Times overlapped"
    end
  end
end
