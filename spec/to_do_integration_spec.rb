require 'capybara/rspec'
require './app'
require 'launchy'

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe 'to_do path', { type: :feature } do
  it 'should be able to create a new list' do
    visit '/'
    click_link 'Add List'
    fill_in 'list_name', with: 'testing'
    click_button 'Submit'
    expect(page).to have_content 'Success'
  end
end
