require 'rails_helper'

RSpec.describe 'Deleted or Inactive links', type: :feature do
  scenario 'when user visits an inactive link' do
    @error_link = create(:link, full_url: 'https://google.com/', active: false)
    visit "/#{@error_link.vanity_string}"
    expect(page).to have_content 'deactivated'
  end

  scenario 'when user visits an deleted link' do
    @error_link = create(:link, full_url: 'https://google.com/', deleted: true)
    visit "/#{@error_link.vanity_string}"
    expect(page).to have_content 'deleted'
  end
end
