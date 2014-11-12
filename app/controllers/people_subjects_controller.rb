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
    puts "CREATE #{@subject}"
    respond_to do |format|
      if @subject.save
        format.html { redirect_to @subject }
      else
        format.html { render 'new' }
      end      
    end
  end

  def search
    @subject = PeopleSubject.new(subject_params)
    conditions = []
    conditions <<= "first_name LIKE '#{params[:first_name]}'" if params[:first_name]
    conditions <<= "last_name LIKE '#{params[:last_name]}'" if params[:last_name]
    conditions <<= "external_link LIKE '#{params[:external_link]}'" if params[:external_link]
    @subjects = PeopleSubject.where(conditions.join(" OR "))
    @enforce_use_of_subject = PeopleSubject.where("external_link IS '#{params[:external_link]}'") if params[:external_link]
    puts search_user_params
    respond_to do |format|
      format.html { render 'new'}
    end
  end

  def adv_search
    keywords = params[:k].split(' ')
    @subject = PeopleSubject.for_keywords(keywords)
  end

private

    def subject_params
      params.require(:people_subject).permit(:first_name, :last_name, :external_link)
    end

    def search_user_params
      params.permit(:first_name, :last_name, :external_link)
    end

    private

    def people_comments_params
      params.require(:people_comment).permit(:content)
    end

end
