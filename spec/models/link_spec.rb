require 'rails_helper'

RSpec.describe Link, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  it 'creates a link when provided with valid credentials' do
    create(:link)
  end

  describe '.validate_full_url' do
    it 'must have a full_url' do
      expect(build(:link, full_url: nil)).to_not be_valid
    end
    it 'must have a valid full_url' do
      expect(build(:link, full_url: 'google')).to_not be_valid
    end
  end
  describe '.validate_vanity_string' do
    it 'must be unique' do
      link1 = create(:link)
      expect(build(:link, vanity_string: link1.vanity_string)).to_not be_valid
    end
  end

  describe '.after_create' do
    it 'must generate a vanity string if none is provided' do
      link = create(:link, vanity_string: nil)
      expect(link.vanity_string.length).to_not be_nil
    end
  end

  describe '.most_popular' do
    it 'excludes links that are deleted' do
      link = create(:link, deleted: true)
      expect(Link.most_popular).to_not include(link)
    end
  end

  describe '.most_recent' do
    it'excludes links that are deleted' do
      link = create(:link, deleted: true)
      expect(Link.most_popular).to_not include(link)
    end
  end
end
