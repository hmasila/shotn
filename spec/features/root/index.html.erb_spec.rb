require 'rails_helper'

RSpec.describe 'root/index.html.erb', type: :feature do
  scenario 'user visits index page' do
    visit root_path
    expect(page).to have_content 'Recent Links'
    expect(page).to have_content 'Popular Links'
    expect(page).to have_content 'Top Users'
  end

  scenario 'user shortens link' do
    visit root_path
    shorten_link
    expect(page).to have_content 'Link generated successfully'
    expect(page).to have_content 'Copy'
  end
end
