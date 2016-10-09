require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create(:user, email: Faker::Internet.email) }

  describe 'associations' do
    it { should have_many(:links) }
  end

  describe '.validate_name' do
    it 'must have a name' do
      expect(build(:user, name: nil).save).to eq false
    end

    it 'must have a proper length' do
      expect(build(:user, name: 'A').save).to eql false
    end

    it 'must have the right characters' do
      expect(build(:user, name: '1234').save).to eql false
    end
  end

  describe '.validate_email' do
    it 'must have an email' do
      expect(build(:user, email: nil).save).to eql false
    end

    it 'must be unique' do
      expect(build(:user, email: user.email).save).to eql false
    end

    it 'must not contain odd characters' do
      expect(build(:user, email: 'weird.character()@.andela.com').save)
        .to eql false
    end
  end

  describe '.validate_password' do
    it 'must have a password' do
      expect(build(:user, password: nil).save).to eql false
    end

    it 'must have the correct length' do
      expect(build(:user, password: 'less').save).to be false
    end

    it 'should not be valid with a confirmation mismatch' do
      expect(
        build(:user, password: '1234', password_confirmation: '5678').save
      ).to eql false
    end
  end

  context 'scope' do
    it 'should return top users depending on their number of links' do
      expect(User.top_users).to_not be_nil
    end
  end
end
