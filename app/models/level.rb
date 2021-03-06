class Level < ActiveRecord::Base
  belongs_to :role
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  validates :required_score, numericality: { only_integer: true }, allow_nill: false

  scope :order_by_required, -> { order(required_score: :desc) }
  scope :by_score, ->(score) { where("required_score <= ?", score).order_by_required }

  def self.first_by_score(score)
    by_score(score).first
  end
end
