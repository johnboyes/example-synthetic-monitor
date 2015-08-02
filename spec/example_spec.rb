require 'rspec'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara/dsl'
require 'spec_helper'

feature "example" do

  before(:all) do
  	@session = Capybara::Session.new(:poltergeist)
  end

  scenario "monitor example.com" do
    @session.visit 'https://www.example.com'
    expect(@session).to have_content("This domain is established to be used for illustrative examples in documents.")
    expect(@session.status_code).to eq(200)
  end

  after(:all) do
    @session.driver.quit
  end

end