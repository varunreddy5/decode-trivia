require 'rails_helper'

RSpec.describe User, type: :model do
  it "ensure name presence" do
    user = FactoryBot.build(:user, name: "")
    expect(user).not_to be_valid
  end
end
