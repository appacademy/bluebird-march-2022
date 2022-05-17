require 'rails_helper'
# unit testing

RSpec.describe User, type: :model do 
  let(:incomplete_user) {User.new(username: '', 
    email: 'empty_username@aa.io',
    password: 'password')}

    # og way of testing ----- start -----
    # it 'validates the presence of a username' do 
    #   expect(incomplete_user).to_not be_valid
    # end
    # ----- end -----

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:age) }
  it { should validate_presence_of(:political_affiliation) }
  it { should validate_presence_of(:password_digest) }
  # it { should validate_presence_of(:session_token) }
  it { should validate_length_of(:password).is_at_least(6) }

  it { should validate_uniqueness_of(:username) }
    subject(:mike) { User.create(
      username: 'mike',
      email: 'mike@aa.io',
      age: 5,
      political_affiliation: 'Hufflepuff',
      password: 'password'
    )
  }

  describe '#is_password?' do 
    let!(:user) { FactoryBot.create(:user) }

    context 'with a valid password' do
      it 'should return true' do 
        expect(user.is_password?('starwars')).to be true
      end
    end

    context 'with an invalid password' do 
      it 'should return false' do
        expect(user.is_password?('startrek')).to be false
      end
    end
  end

  describe "password encryption" do 
    it 'does not save passwords in the database' do 
      FactoryBot.create(:user, username: 'Luke Skywalker')

      user = User.find_by(username: 'Luke Skywalker')
      expect(user.password).not_to eq('starwars')
    end

    it 'encrypts password using BCrypt' do 
      expect(BCrypt::Password).to receive(:create).with('abcde')

      FactoryBot.build(:user, password: 'abcde')
    end
  end
end