class PeopleSubject < ActiveRecord::Base
  has_many :people_comments, dependent: :destroy
  default_scope -> { order('created_at DESC') }
  belongs_to :user
  
end
