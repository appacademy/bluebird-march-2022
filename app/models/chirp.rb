# == Schema Information
#
# Table name: chirps
#
#  id         :bigint           not null, primary key
#  body       :string(140)      not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Chirp < ApplicationRecord
    validates :body, :author_id, presence: true
    # validate :body, length: { maximum: 140 }
    validate :body_too_long

    def body_too_long
        if body && body.length > 140
            errors[:body] << "too long"
        end
    end

    belongs_to :author,
        primary_key: :id,
        foreign_key: :author_id,
        class_name: :User
        
    has_many :likes,
        primary_key: :id,
        foreign_key: :chirp_id,
        class_name: :Like

    has_many :likers,
        through: :likes,
        source: :liker

     # Includes 

  def self.see_chirp_authors_n_plus_one
      # the "+1"
      chirps = Chirp.all

      # the "N"
      chirps.each do |chirp|
          puts chirp.author.username
      end

  end

  def self.see_chirps_optimized
      # pre-fetches data
      chirps = Chirp.includes(:author).all

      chirps.each do |chirp| 
      # uses pre-fetched data 
          puts chirp.author.username
      end
  end

  # Joins #

  def self.see_chirp_num_likes_n_plus_one
      chirps = Chirp.all

      chirps.each do |chirp|
          puts chirp.likes.length
      end
  end

  def self.see_chirp_num_likes_optimized
      chirps_with_likes = Chirp
          .select("chirps.*, COUNT(*) AS num_likes")
          .joins(:likes)
          .group(:id)
  
      chirps_with_likes.each do |chirp|
          puts chirp.num_likes
      end
  end

end

  # demo 2

  # Find all chirps for a particular user
  # Chirp.joins(:author).where(users: {username: "instructors_rock"})
  # SQL equiv = WHERE users.username = ""

  # joins always ALWAYS ALWAYS takes in an association

  # Find all chirps liked by people politically affiliated with JavaScript
  # Chirp.joins(:likers).where("users.political_affiliation = (?)", "JavaScript")

  #Get only the unique values from the previous query
  # ------------ DISTINCT ---------------
  # Chirp.joins(:likers).where("users.political_affiliation = (?)", "JavaScript").distinct
  # also add how we can use group
#  --------------- GROUP ----------------
  # Chirp.joins(:likers).group(:id).where("users.political_affiliation = (?)", "JavaScript")

  #Find all chirps with no likes
  # Chirp.left_outer_joins(:likes).where(likes: {id: nil})

  #Find how many likes each chirp has
  # Chirp.select(:id, :body, "COUNT(*) AS num_likes").joins(:likes).group(:id)

  #Find chirps with at least 3 likes
  # Chirp.joins(:likes).group(:id).having("COUNT(*) >= ?", 3).pluck(:body)
  # Chirp.joins(:likes).group(:id).having("COUNT(*) >= ?", 3).select(:body)


