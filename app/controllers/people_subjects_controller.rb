class PeopleSubjectsController < ApplicationController
  
  def show
  	@subject = PeopleSubject.find(params[:id])
    # this list i use to communicate between the Subjects controller and Comments controller
    Rails.cache.write("list",@subject.id)

    @comment = PeopleComment.new(content: "", people_subject_id: @subject_id)

  	@people_comments = @subject.people_comments.paginate(page: params[:page])
    user_is_false
    	
  end

  def new
  	@subject = PeopleSubject.new
  end
  
  def create
  	 @subject = PeopleSubject.new(subject_params)
     @subject.user_id = current_user.id   
    if @subject.save
     # flash[:success] = "Welcome to the CommentOn!"
     redirect_to @subject 
    else
     render 'new'
    end
end


private

    def subject_params
      params.require(:people_subject).permit(:first_name, :last_name, :external_link)
    end
    private

    def people_comments_params
      params.require(:people_comment).permit(:content)
    end

end
