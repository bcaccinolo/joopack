class SkillsController < ApplicationController
                
  layout false
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @skill_pages, @skills = paginate :skills, :per_page => 10
  end

  def show
    @skill = Skill.find(params[:id])
  end

  def new
    @skill = Skill.new
  end


  def create
    @user = current_user      
    @cv = @user.cvs.find :first
    if params['id'] != "cancel"
      params[:skill]['cv_id'] = @cv.id
      params[:skill][:position] = @cv.get_next_skill_position      
      @skill = Skill.new(params[:skill])
      @skill.save
      @cv.reload
    end
  end

  def edit
    @skill = Skill.find(params[:id])
  end

 def update
    @skill = Skill.find(params[:id])
    @skill.update_attributes(params[:skill])
    @user = current_user
  end
  
  def order
    params[:skill_list].each do |elem_id|
      Skill.update(elem_id, {:position => params[:skill_list].index(elem_id)})
    end
    render :nothing => true
  end  

  def destroy
    Skill.find(params[:id]).destroy
  end
end
