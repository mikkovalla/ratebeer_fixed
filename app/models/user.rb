class User < ActiveRecord::Base
	include RatingAverage
	extend Top

	has_many :ratings, dependent: :destroy
	has_many :beers, through: :ratings
	has_many :styles
	has_many :memberships, dependent: :destroy
	has_many :beer_clubs, through: :memberships

	has_secure_password

	validates :username, uniqueness: true,
						length: { in: 3..30 }
	validates :password, length: { minimum: 4 }
	validates :password, format: { with: /([A-Z].*\d)|(\d.*[A-Z].*)/, message: "should contain one number and one capital letter" }

	def favorite_beer
		return nil if ratings.empty?
		ratings.order(score: :desc).limit(1).first.beer
	end

	def favorite_style
		return nil if ratings.empty?
		style_id = ratings.joins(:beer).group(:style_id).average('score').max_by{ |k, v| v}.first
		Style.find(style_id).name
	end

	def favorite_brewery
		return nil if ratings.empty?
		Brewery.find(ratings.joins(:beer).group("brewery_id").average('score').max_by{ |k, v| v}.first).name
	end
end
