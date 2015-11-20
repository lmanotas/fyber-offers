require 'spec_helper'

describe 'app' do
  
  describe 'home page' do
    it 'should have a div#main container' do
      visit '/'
      expect(page).to have_content('Offers')
    end
  end

  describe '404 not found' do
    it 'should show an 404 error when page does not exist' do
      visit '/not_existing_error'
      expect(page).to have_content('Page Not Found')
    end
  end
  
end