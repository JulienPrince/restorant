class Restaurant < ApplicationRecord
  has_one :user
  has_many :commentaires, dependent: :destroy

  has_one_attached :photo_file

  before_save :uploadeTrue
  after_save :uploadeFalse

  validates :nom_restaurant, presence: true
  validates_uniqueness_of :nom_restaurant
  validates :prix, presence: true


  def self.search(params)
    restaurant= Restaurant.where("nom_restaurant LIKE ?", "%#{params[:search]}%")
    if params[:search].present?
      restaurant
    end
  end

 

    def uploadeTrue
      if photo_file.respond_to? :path
        self.upload = true
      end
    end

      def uploadeFalse
      if photo_file.respond_to? :path
        self.upload = false
      end
    end
  
end
