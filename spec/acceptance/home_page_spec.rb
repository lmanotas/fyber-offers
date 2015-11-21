require 'spec_helper'

describe 'app', type: :acceptance do

  def fill_get_offer_form
    fill_in 'uid', with: 'player1'
    fill_in 'page', with: '1'
    fill_in 'pub0', with: 'campaign2'
    click_button 'Get Offers'
  end
  
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

  describe 'use form to get offers' do
    valid_offers_response

    it 'should use Fyber::Offer to get the offers from the API' do
      visit '/'
      fill_get_offer_form

      expect(page).to have_content('Tap  Fish')
    end
  end

  describe 'show error returned from the API' do
    offers_response_with_error

    it 'render error message when something goes wrong with the Fyber::Offer API request' do
      visit '/'
      fill_get_offer_form

      expect(page).to have_content("A non-existing page was requested with the parameter page.")
    end
  end

  describe 'no offers message' do
    no_offers_response
    
    it 'show no offers found message' do
      visit '/'
      fill_get_offer_form

      expect(page).to have_content('No offers available')
    end
  end
end