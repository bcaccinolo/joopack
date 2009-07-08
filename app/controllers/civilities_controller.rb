class CivilitiesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @civility_pages, @civilities = paginate :civilities, :per_page => 10
  end

  def show
    @civility = Civility.find(params[:id])
  end

  def info_form
  end

  def new
    @civility = Civility.new
  end

  def create
    if not session[:user].nil?
      params[:civility]['user_id'] = session[:user]
    end
    
    @civility = Civility.new(params[:civility])
    @civility.save
  end

  def edit
    @civility = Civility.find(params[:id])
  end

  def update
    @civility = Civility.find(params[:id])
    @civility.update_attributes(params[:civility])
  end

  def destroy
    Civility.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
