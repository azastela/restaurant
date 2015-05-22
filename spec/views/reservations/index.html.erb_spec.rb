require 'rails_helper'

RSpec.describe "reservations/index", :type => :view do
  before(:each) do
    assign(:reservations, [
      Reservation.create!(),
      Reservation.create!()
    ])
  end

  it "renders a list of reservations" do
    render
  end
end
