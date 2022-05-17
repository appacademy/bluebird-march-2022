require 'rails_helper'
# e2e  tesing 

feature 'Creating a Chirp', type: :feature do
  before :each do 
    FactoryBot.create(:user)
  end

  scenario 'takes a body' do 
    log_in_user(User.last)
    visit new_chirp_url
    expect(page).to have_content 'New chirp'
    expect(page).to have_content 'Body'
  end

  scenario 'takes user to chirp show' do 
    log_in_user(User.last)
    make_chirp("It's sunny outside")

    expect(page).to have_content("It's sunny outside")
    expect(current_path).to eq(chirp_path(Chirp.last))
  end

  feature 'Deciphering a Chirp', type: :feature do 
    before :each do 
      FactoryBot.create(:user)
      log_in_user(User.last)
      make_chirp("to_be_deleted")
      click_button('Delete this Chirp')
    end

    scenario 'dechirps a chirp' do 
      expect(page).to_not have_content("to_be_deleted")
      expect(page).to have_content("All the chirps!")
      expect(current_path).to eq(chirps_path)
    end
  end

end