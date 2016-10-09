require 'rails_helper'

RSpec.describe 'links/error.html.erb', type: :feature do
  scenario 'when link is Inactive' do
    @error_link = create(:link, full_url: 'https://google.com/', active: false)
    visit "/#{@error_link.vanity_string}"
    expect(page).to have_content 'deactivated'
  end

  scenario 'when link is deleted' do
    @error_link = create(:link, full_url: 'https://google.com/', deleted: true)
    visit "/#{@error_link.vanity_string}"
    expect(page).to have_content 'deleted'
  end
end
