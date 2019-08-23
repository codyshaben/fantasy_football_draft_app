require_relative '../spec_helper'

describe 'user' do
    it 'cannot access teams page without authorization' do
        visit '/logout'
        visit '/teams'
        page.should have_content('The page you were looking for doesn\'t exist.')
    end

    it 'cannot access stats page without authorization' do 
        visit '/logout'
        visit '/stats'
        page.should have_content('The page you were looking for doesn\'t exist.')
    end

    it 'cannot access players page without authorization' do 
        visit '/logout'
        visit '/players'
        page.should have_content('The page you were looking for doesn\'t exist.')
    end

    it 'can\'t login if invalid credentials' do 
        visit '/logout'
        visit '/'
        click_button('Log In')
        page.should have_content('Something went wrong, please try again.')
    end
end