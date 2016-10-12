require 'rails_helper'

RSpec.describe Link, type: :model do
  subject(:link) { create :link }
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
    it 'must have a title' do
      expect(link.title).to_not be_nil
    end
  end

  describe '.most.popular' do
    let(:link) { create(:link, deleted: true) }
    it 'excludes links that are deleted' do
      expect(Link.most.popular).to_not include(link)
    end
  end

  describe '.most.recent' do
    let(:link) { create(:link, deleted: true) }
    it'excludes links that are deleted' do
      expect(Link.most.recent).to_not include(link)
    end
  end
end
