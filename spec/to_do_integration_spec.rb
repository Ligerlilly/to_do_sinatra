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

  it 'should allow the user to add a new task for a list' do
    list = List.new({name: "asdf", id: nil})
    list.save
    visit '/'
    expect(page).to have_content 'asdf'
    click_link 'asdf'
    expect(page).to have_content 'There are no lists'
    fill_in 'task_description', with: 'bob'
    click_button 'Submit'
    expect(page).to have_content 'bob'
  end
end
