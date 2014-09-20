require 'spec_helper'

describe User do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email_address) }
  it { should validate_presence_of(:hashed_screen_name) }

  describe 'email address' do
    it { should allow_value("test@test2.com").for(:email_address) }
    it { should_not allow_value("%test@test2.com").for(:email_address) }

    it 'validates uniqueness' do
      u = FactoryGirl.create(:user)
      expect{ FactoryGirl.create(:user, email_address: u.email_address.capitalize) }.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
