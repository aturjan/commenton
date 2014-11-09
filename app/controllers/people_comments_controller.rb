class PeopleCommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    
    @people_comment = current_user.people_comments.build(people_comments_params)
    #get the people subject if (set by the people subjects controller)
    @people_comment.people_subject_id = Rails.cache.read("list")
    
     if @people_comment.save
      redirect_to :back
    else
      #perhaps i need to change to another link + make some proper message in case of error
      redirect_to :back
    end
  end

  def destroy
  end

  private

    def people_comments_params
      params.require(:people_comment).permit(:content)
    end
end