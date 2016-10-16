require 'rails_helper'

RSpec.describe 'Display Link Details', type: :feature do
  let(:user) { create(:user) }

  before(:each) do
    sign_in_with(user.email, user.password)
    create_link
    find_link_id
    visit "/links/#{@link.id}"
  end

  scenario 'user views link details' do
    expect(page).to have_content @full_url
    expect(page).to have_content 'Shortened URL'
    expect(page).to have_content 'Active'
    expect(page).to have_content 'Deleted'
    expect(page).to have_content @vanity
  end

  scenario 'user clicks back link' do
    click_link 'Back'
    expect(page.current_path).to eq '/home'
  end
end
