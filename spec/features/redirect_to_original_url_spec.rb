require 'rails_helper'

RSpec.describe 'Redirect to original url', type: :feature do
  let(:user) { create(:user) }

  before do
    sign_in_with(user.email, user.password)
    create_link
  end

  scenario 'when user clicks a vanity_string' do
    first(:link, root_url + @vanity).click
    expect(page.current_url).to eq @full_url
  end

  scenario 'when user clicks a deactivated vanity_string' do
    click_link 'Manage'
    choose 'Inactive'
    click_button 'Update'
    first(:link, root_url + @vanity).click
    expect(page.current_path).to eq "/error/#{@vanity}"
    expect(page).to have_content 'This link has been deactivated by the owner'
  end

  scenario 'when user clicks a deactivated vanity_string' do
    click_link 'Manage'
    click_link 'Delete'
    first(:link, root_url + @vanity).click
    expect(page.current_path).to eq "/error/#{@vanity}"
    expect(page).to have_content 'You deleted this link'
  end
end
