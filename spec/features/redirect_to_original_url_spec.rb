require 'rails_helper'

RSpec.describe 'Redirect to original url', type: :feature do
  scenario 'when user clicks a vanity_string' do
    visit root_path
    create_link
    first(:link, root_url + @vanity).click
    expect(page.current_url).to eq @full_url
  end
end
