require 'rails_helper'

RSpec.describe 'links/edit.html.erb', type: :feature do
  let(:user) { create(:user) }

  before { sign_in_with(user.email, user.password) }
  scenario 'user shortens link' do
    create_link
    expect(page).to have_content 'Link generated successfully'
    expect(page).to have_content 'Copy'
    expect(page).to have_content root_url + @vanity
  end

  scenario 'link redirects to full_url path' do
    create_link
    expect(page).to have_content root_url + @vanity
    first(:link, root_url + @vanity).click
    expect(page.current_url).to eq @full_url
  end

  scenario 'user logs out' do
    visit home_path
    expect(page).to have_content 'Logout'
    click_link 'Logout'
    expect(page.current_path).to eq root_path
  end

  scenario 'user clicks manage' do
    create_link
    find_link_id
    expect(page).to have_content 'Manage'
    click_link 'Manage'
    expect(page.current_path).to eq "/links/#{@link.id}/edit"
  end

  scenario 'user clicks details' do
    create_link
    find_link_id
    expect(page).to have_content 'Details'
    click_link 'Details'
    expect(page.current_path).to eq link_path(@link)
  end
end
