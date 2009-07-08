class HobbiesController < ApplicationController
  
    layout false

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @hobby_pages, @hobbies = paginate :hobbies, :per_page => 10
  end

  def show
    @hobby = Hobby.find(params[:id])
  end

  def new
    @hobby = Hobby.new
  end

  def create
    @user = current_user      
    @cv = @user.cvs.find :first
    if params['id'] != "cancel"
      params[:hobby]['cv_id'] = @cv.id
      params[:hobby][:position] = @cv.get_next_hobby_position      
      @hobby = Hobby.new(params[:hobby])
      @hobby.save
      @cv.reload
    end
  end

  def edit
    @hobby = Hobby.find(params[:id])
  end

  def update
    @hobby = Hobby.find(params[:id])
    @hobby.update_attributes(params[:hobby])
    @user = current_user
  end

  def order
    params[:hobby_list].each do |elem_id|
      Hobby.update(elem_id, {:position => params[:hobby_list].index(elem_id)})
    end
    render :nothing => true
  end

  def destroy
    Hobby.find(params[:id]).destroy
  end
end
