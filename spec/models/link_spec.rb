require 'rails_helper'

RSpec.describe Link, type: :model do
  subject(:link) do
    create(:link)
  end
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe '.validate_full_url' do
    it 'must have a full_url' do
      expect(build(:link, full_url: nil).save).to eql false
    end

    it 'must have a valid full_url' do
      expect(build(:link, full_url: 'aaaaa').save).to eql false
    end
  end

  describe '.validate_vanity_string' do
    it 'must have a vanity_string' do
      expect(build(:link, vanity_string: nil).save).to eql false
    end

    it 'must have a unique vanity_string' do
      expect(build(:link, vanity_string: link.vanity_string).save).to eql false
    end

    it 'must be less than 6 characters' do
      expect(build(:link, vanity_string: 'my_vanity_string').save).to eql false
    end
  end

  describe '.after_create' do
    it 'must have a title' do
      expect(link.title).to_not be_nil
    end
  end

  describe '.most_popular' do
    let(:link) do
      create(:link, deleted: true)
    end
    it 'excludes links that are deleted' do
      expect(Link.most_popular).to_not include(link)
    end
  end

  describe '.most_recent' do
    let(:link) do
      create(:link, deleted: true)
    end
    it'excludes links that are deleted' do
      expect(Link.most_popular).to_not include(link)
    end
  end
end
