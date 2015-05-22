require 'rails_helper'

RSpec.describe "reservations/show", :type => :view do
  before(:each) do
    @reservation = assign(:reservation, Reservation.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
