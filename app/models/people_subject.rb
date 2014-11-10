class PeopleSubject < ActiveRecord::Base
  has_many :people_comments, dependent: :destroy
  default_scope -> { order('created_at DESC') }
  belongs_to :user
  

  def self.for_keywords(keywords)
  	return self.where(condition_for_keywords(keywords).join(' OR '))
  end

private

  def self.condition_for_keywords(keywords)
    list = keywords.map{ |a| "'#{a}'" }.join(',')
    return [
      keywords.map { |a| "first_name LIKE '#{a}'" },
      keywords.map { |a| "last_name LIKE '#{a}'" },
    ].flatten!
  end
end
