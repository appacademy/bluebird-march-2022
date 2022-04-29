# == Schema Information
#
# Table name: users
#
#  id                    :bigint           not null, primary key
#  username              :string           not null
#  email                 :string           not null
#  password              :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  political_affiliation :string           not null
#  age                   :integer          not null
#
class User < ApplicationRecord
    validates :username, :email, :password, :age, :political_affiliation, presence: true

    has_many :chirps,
        primary_key: :id,
        foreign_key: :author_id,
        class_name: :Chirp

    has_many :likes,
        primary_key: :id,
        foreign_key: :liker_id,
        class_name: :Like

    has_many :liked_chirps,
        through: :likes,
        source: :chirp

    #Get first user record, use first
    # User.first

    #Get last user record, use last
    # User.last

    #Find a user that exists by id, use find
    # User.find(12)

    #Find a user that doesn't exist by id, use find
    #  User.find(37)

    #Find a user by username, use find_by
    #  User.find_by(username: “alvin_aka_mr_structy”)
    
    #Find a user by username that does not exist, use find_by
    # User.find_by(username: "alviny")


    #Find all users between the ages of 10 and 20 inclusive. Show their username, and political affiliation.
    # User.where(age: 10..20).select(:username, :political_affiliation)

    #Find all users not younger than the age of 11. Use `where.not`
    # User.where.not("age <= ?", 11)

    #Find all political_affiliations of our users
    # User.select(:political_affiliation).group(:political_affilication)

    # User.select(:political_affiliation).distinct

    # BONUS
    #Find all users who have a political affiliation in this list and order by ascending
    # political_affiliations = ["Ruby", "JavaScript"]

    # User.where(political_affiliation: ["Ruby", "JavaScript"]).order(username: :asc)


end
