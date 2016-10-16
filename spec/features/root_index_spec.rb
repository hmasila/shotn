require 'rails_helper'

RSpec.describe 'Shotn Root page', type: :feature do
  let(:user) { create(:user) }

  let(:link) { create(:link, user_id: user.id) }

  scenario 'user visits index page' do
    visit root_path
    expect(page).to have_content 'Recent Links'
    expect(page).to have_content 'Popular Links'
    expect(page).to have_content 'Top Users'
  end

  scenario 'user clicks on most popular' do
    visit root_path
    click_link 'Popular Links'
    expect(page).to have_content link.title
  end

  scenario 'user clicks on most_recent' do
    visit root_path
    click_link 'Recent Links'
    expect(page).to have_content link.title
  end

  scenario 'user clicks on top_users' do
    visit root_path
    click_link 'Top Users'
    expect(page).to have_content user.name
  end
end
