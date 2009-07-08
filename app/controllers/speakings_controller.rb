class SpeakingsController < ApplicationController

  layout false

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @speaking_pages, @speakings = paginate :speakings, :per_page => 10
  end

  def show
    @speaking = Speaking.find(params[:id])
  end

  def new
    @speaking = Speaking.new
  end

  def create
    @user = current_user      
    @cv = @user.cvs.find :first
    if params['id'] != "cancel"
      params[:speaking]['cv_id'] = @cv.id 
      params[:speaking][:position] = @cv.get_next_speaking_position      
      @speaking = Speaking.new(params[:speaking])
      @speaking.save
      @cv.reload
    end
  end

  def edit
    @speaking = Speaking.find(params[:id])
  end

  def update
    @speaking = Speaking.find(params[:id])
    @speaking.update_attributes(params[:speaking])
    @user = current_user
  end

  def order
    params[:speaking_list].each do |elem_id|
      Speaking.update(elem_id, {:position => params[:speaking_list].index(elem_id)})
    end
    render :nothing => true
  end

  def destroy
    Speaking.find(params[:id]).destroy
  end
end
