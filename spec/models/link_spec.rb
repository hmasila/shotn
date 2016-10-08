require 'rails_helper'

RSpec.describe Link, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  context 'validations' do
    subject { Link.new(full_url: 'https://google.com') }
    it { should validate_presence_of :full_url }
    it { should validate_presence_of :vanity_string }
    it { should validate_uniqueness_of :vanity_string }

    it { should have_db_column :vanity_string }
    it { should have_db_column :title }
    it { should have_db_column :clicks }
    it { should have_db_column :user_id }
    it { should have_db_index :user_id }
  end

  describe '.most_popular' do
    it 'excludes links that are deleted' do
      link = create(:link, full_url: 'https://www.google.com', deleted: true)
      expect(Link.most_popular).to_not include(link)
    end
  end

  describe '.most_recent' do
    it'excludes links that are deleted' do
      link = create(:link, full_url: 'https://www.google.com', deleted: true)
      expect(Link.most_popular).to_not include(link)
    end
  end
end
