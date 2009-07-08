class ExperiencesController < ApplicationController

  layout false

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @experience_pages, @experiences = paginate :experiences, :per_page => 10
  end

  def one_exp
    exp = Experience.find(params[:id])
    render :partial => "exp_one", :locals => {"e" => exp, "user_id" => exp.user_id }
  end

  def show
    @user = User.find_by_login(params[:id])    
    if (not params['type'].nil? ) and params['type'] == "one"
      @current_type = "one"
      @future_type = ""
    else
      @current_type = ""
      @future_type = "one"
    end
    
  end

  def new
    @experience = Experience.new
  end

  def create
    @user = current_user      
    @cv = @user.cvs.find :first
    if params['id'] != "cancel"

      params[:experience]['cv_id'] = @cv.id
      params[:experience][:begin] = params[:experience]["begin_month"] + " " + params[:experience]["begin_year"]
      params[:experience].delete "begin_month"
      params[:experience].delete "begin_year"
      if params[:experience][:in_post] == "1"
        params[:experience][:end] = "IN_POST"
      else
        params[:experience][:end] = params[:experience]["end_month"] + " " + params[:experience]["end_year"]
      end
      params[:experience].delete "in_post"
      params[:experience].delete "end_month"
      params[:experience].delete "end_year"
      params[:experience][:position] = @cv.get_next_experience_position
      if !params.include?(:add_details)
        params[:experience][:details] = ""
      end
      @experience = Experience.new(params[:experience])
      @experience.save
      @cv.reload      
    end
  end

  def edit
    @experience = Experience.find(params[:id])
  end

  def update
    @experience = Experience.find(params[:id])
    if !params.include?(:add_details)
      params[:experience][:details] = ""
    end
    params[:experience][:begin] = params[:experience]["begin_month"] + " " + params[:experience]["begin_year"]
    params[:experience].delete "begin_month"
    params[:experience].delete "begin_year"

    if params[:experience][:in_post] == "1"
      params[:experience][:end] = "IN_POST"
    else
      params[:experience][:end] = params[:experience]["end_month"] + " " + params[:experience]["end_year"]
    end
      params[:experience].delete "in_post"
      params[:experience].delete "end_month"
      params[:experience].delete "end_year"
    @experience.update_attributes(params[:experience])
    @user = current_user
  end

  def order
    params[:exp_list].each do |elem_id|
      Experience.update(elem_id, {:position => params[:exp_list].index(elem_id)})
    end
    render :nothing => true
  end

  def destroy
    @id = params[:id]
    Experience.find(params[:id]).destroy
  end
end
