require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:links) }

  it 'creates a new user when passed with valid attributes' do
    user = FactoryGirl.create(:user)
    expect(user).to be_valid
  end

  describe '.before_save' do
    it 'converts all emails to lowercase' do
      user = create(:user)
      expect(user.email).to eql 'maslah.kibe@andela.com'
    end
    it 'encrypts the password' do
      user = create(:user, password: 'maslah')
      user.password_digest = BCrypt::Engine.hash_secret(user.password,
                                                        user.salt)
    end
  end

  describe '.validate_name' do
    it 'must have a name' do
      expect(build(:user, name: nil)).to_not be_valid
    end
    it 'must have a proper length' do
      expect(build(:user, name: 'f')).to_not be_valid
    end
    it 'must have the right characters' do
    expect(build(:user, name: '9*Yt')).to_not be_valid
    end
  end

  describe '.validate_email' do
    it 'must have an email' do
      expect(build(:user, email: nil)).to_not be_valid
    end

    it 'must contain only allowed characters' do
      email = 'maslah.kibe()@.andela.com'
      expect(build(:user, email: email)).to_not be_valid
    end

    it 'must be unique' do
      user1 = create(:user)
      user2 = build(:user, email: user1.email)
      expect(user2).to_not be_valid
    end
  end

  describe '.validate_password' do
    it 'ensures a password is supplied, it cannot be nil' do
      expect(build(:user, password: nil)).to_not be_valid
    end
    it 'must have the correct length' do
      expect(build(:user, password: 'an')).to_not be_valid
    end
  end
end
