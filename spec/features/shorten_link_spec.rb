require 'rails_helper'

RSpec.describe 'Shorten link', type: :feature do
  let(:user) { create(:user) }

  scenario 'logged in user shortens link' do
    sign_in_with(user.email, user.password)
    create_link
    expect(page).to have_content 'Link generated successfully'
    expect(page).to have_content 'Copy'
    expect(page).to have_content root_url + @vanity
  end

  scenario 'anonymous user shortens link' do
    visit root_path
    shorten_link
    expect(page).to have_content 'Link generated successfully'
    expect(page).to have_content 'Copy'
  end
end
