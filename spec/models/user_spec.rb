require 'rails_helper'

RSpec.describe User, :type => :model do
  it "user role is normal user after initialization" do
    user = User.new
    expect(user.role.to_s).to eq (:user).to_s
  end
end
