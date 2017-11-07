require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:links) }

  it { should validate_presence_of :password }
  it { should have_secure_password }
  it { should validate_confirmation_of :password }
  it { should validate_length_of(:password).is_at_least(5) }

  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }
  it { should_not allow_value('examp@le@test.com').for(:email) }

  it { should have_db_index :email }
  it { should have_db_column :link_count }
  it { should have_db_column :password_digest }
  it { should have_db_column :email }

  it { should validate_presence_of :name }
  it { should_not allow_value('12345').for(:name) }
  it do
    should validate_length_of(:name).is_at_least(2)
  end

  describe '.top_users' do
    it 'should return top users depending on their number of links' do
      expect(User.top_users).to_not be_nil
    end
  end
end
