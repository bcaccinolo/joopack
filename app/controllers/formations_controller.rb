class FormationsController < ApplicationController

  layout false
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @formation_pages, @formations = paginate :formations, :per_page => 10
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
  
  def form_form
  end
  
  def one
    form = Formation.find(params[:id])
    render :partial => "one", :locals => {"f" => form, "user_id" => form.user_id }
  end

  def new
    @formation = Formation.new
  end  

  def create
    @user = current_user
    @cv = @user.cvs.find :first
    if params['id'] != "cancel"

      params[:formation]['cv_id'] = @cv.id

      params[:formation][:date] = params[:formation][:date_month] + " " + params[:formation][:date_year]
      params[:formation].delete :date_month
      params[:formation].delete :date_year

      params[:formation][:position] = @cv.get_next_formation_position
      @formation = Formation.new(params[:formation])
      @formation.save
      @cv.reload
    end
    
  end

  def edit
    @formation = Formation.find(params[:id])
  end

  def update
    @formation = Formation.find(params[:id])
    params[:formation][:date] = params[:formation][:date_month] + " " + params[:formation][:date_year]
    params[:formation].delete :date_month
    params[:formation].delete :date_year
    @formation.update_attributes(params[:formation])
    @user = current_user
  end

  def order
    params[:formation_list].each do |elem_id|
      Formation.update(elem_id, {:position => params[:formation_list].index(elem_id)})
    end
    render :nothing => true
  end

  def destroy
    Formation.find(params[:id]).destroy
  end
end
