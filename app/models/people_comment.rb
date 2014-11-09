class PeopleComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :people_subject
  default_scope -> { order('created_at DESC') }
  
  validates :content, presence: true, length: { maximum: 140 }

end
