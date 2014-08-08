require 'rails_helper'

RSpec.describe Reservation, :type => :model do
  before { @reservation = Reservation.new(start_time: "03-08-2014 16:00", end_time: "03-08-2014 18:00", table_id: 10 )}

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
  
end
