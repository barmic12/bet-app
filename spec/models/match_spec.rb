require 'rails_helper'

RSpec.describe Match, type: :model do

  it "has a valid factory" do
    expect(build(:match)).to be_valid
  end

  # Lazily loaded to ensure it's only used when it's needed
  # RSpec tip: Try to avoid @instance_variables if possible. They're slow.
  let(:match_instance) { build(:match) }

  describe "ActiveModel validations" do
    # Basic validations
    it { expect(match_instance).to validate_presence_of(:host) }
    it { expect(match_instance).to validate_presence_of(:guest) }
    it { expect(match_instance).to validate_presence_of(:date) }

    # Format validations
    it { expect(match_instance).to_not allow_value("2-1").for(:score)}
    it { expect(match_instance).to allow_value("2:1").for(:score) }

    # Inclusion/acceptance of values
    it { expect(match_instance).to validate_length_of(:score).is_at_least(3)}
  end

  describe "ActiveRecord associations" do
    # Associations
    it { expect(match_instance).to belong_to(:tournament) }
    it { expect(match_instance).to have_many(:types) }
  end

end
