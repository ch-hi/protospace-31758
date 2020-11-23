class Prototype < ApplicationRecord
  belongs_to :user #アソシエーション
  has_one_attached :image
  has_many :comments, dependent: :destroy #関連テーブルのレコードも削除

  validates :title, presence: true
  validates :catch_copy, presence: true
  validates :concept, presence: true  
  validates :image, presence: true


  # validates :image, presence: true
end