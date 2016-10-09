require 'rails_helper'

RSpec.describe 'links/edit.html.erb', type: :feature do
  let(:user) { create(:user) }
  before(:each) do
    sign_in_with(user.email, user.password)
    create_link
    find_link_id
    visit "/links/#{@link.id}/edit"
  end

  scenario 'user changes the target of a shortened url' do
    @update_vanity = Faker::Internet.password(2, 6)
    fill_in 'link_vanity_string', with: @update_vanity
    click_button 'Update'
    expect(page).to have_content 'Link updated successfully'
    expect(page.current_path).to eq '/home'
    expect(page).to have_content root_url + @update_vanity
    first(:link, root_url + @update_vanity).click
    expect(page.current_url).to eq @full_url
  end

  scenario 'user deactivates a link' do
    choose 'Inactive'
    click_button 'Update'
    expect(page.current_path).to eq '/home'
    first(:link, root_url + @vanity).click
    expect(page).to have_content 'deactivated'
  end

  scenario 'user deletes a link' do
    click_link 'Delete'
    expect(page.current_path).to eq '/home'
    first(:link, root_url + @vanity).click
    expect(page).to have_content 'deleted'
  end

  scenario 'user deactivates a link' do
    choose 'Inactive'
    click_button 'Update'
    visit "/links/#{@link.id}/edit"
    choose 'Active'
    click_button 'Update'
    expect(page.current_path).to eq '/home'
    first(:link, root_url + @vanity).click
    expect(page.current_url).to eq @full_url
  end
end
