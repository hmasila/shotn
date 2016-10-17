require 'rails_helper'

RSpec.describe Link, type: :model do
  subject(:link) { create :link, deleted: true }

  it { should belong_to(:user) }

  it { should validate_presence_of :full_url }
  it { should_not allow_value('not a url').for(:full_url) }
  it { should validate_presence_of :vanity_string }
  it { should validate_uniqueness_of :vanity_string }
  it { should validate_length_of(:vanity_string).is_at_most(6) }

  it { should have_db_column :vanity_string }
  it { should have_db_column :title }
  it { should have_db_column :clicks }
  it { should have_db_column :user_id }
  it { should have_db_index :user_id }

  describe '#link_title' do
    it 'creates the link title' do
      expect(link.title).to eq 'Google'
    end

    it 'link title should not be nil' do
      expect(link.title).to_not be_nil
    end
  end

  describe '.most_popular' do
    it 'excludes links that are deleted' do
      expect(Link.most_popular).to_not include(link)
    end

    it 'should include active_link' do
      popular_link = (create :link)
      expect(Link.most_popular.last.title).to eq popular_link.title
    end
  end

  describe '.most_recent' do
    it'excludes links that are deleted' do
      expect(Link.most_recent).to_not include(link)
    end

    it 'should include active_link' do
      recent_link = (create :link)
      expect(Link.most_recent.last.title).to eq recent_link.title
    end
  end

  describe '.links' do
    it 'returns user links starting with the most recent' do
      user = create(:user, email: 'user@email.com')
      link = create(:link, user_id: user.id)
      expect(Link.links(user)).to include(link)
    end
  end
end
