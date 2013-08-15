class Skill < ActiveRecord::Base
  VALID_CONTEXTS = %w(technical creative)

  has_many :proficiencies
  has_many :users, through: :proficiencies

  validates :name, :presence => true
  validate :validate_context

  def proficiency=(year_experience, formal, user_id)
    self.formal.clear
    self.year_experience.clear
    self.proficiencies << Proficiency.create(user_id: user_id, year_experience: year_experience, formal: formal)
  end

  private
  def validate_context
    p self.context
    self.errors[:context] = "must be one of: #{VALID_CONTEXTS.join(', ')}" unless VALID_CONTEXTS.include? self.context
  end
end
