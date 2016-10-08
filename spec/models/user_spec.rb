require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it { should validate_presence_of :password }
    it { should have_secure_password }
    it { should validate_confirmation_of :password }

    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should allow_value('example@test.com').for(:email) }

    it { should have_db_index :email }
    it { should have_db_column :link_count }
    it { should have_db_column :password_digest }

    it { should validate_presence_of :name }
    it { should_not allow_value('12345').for(:name) }
    it do
      should validate_length_of(:name).is_at_least(2)
        .with_message(/too short. Minimum length is two characters/)
    end
  end

  context 'associations' do
    it { should have_many(:links) }
  end

  context 'scope' do
    it 'should return top users depending on their number of links' do
      expect(User.top_users).to eq ['users.links DESC']
    end
  end
end
