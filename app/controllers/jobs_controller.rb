class JobsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @jobs_pages, @jobs = paginate :jobs, :per_page => 10
  end

  def show
    @jobs = Jobs.find(params[:id])
  end

  def new
    @jobs = Jobs.new
  end

  def create
    @jobs = Jobs.new(params[:jobs])
    if @jobs.save
      flash[:notice] = 'Jobs was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @jobs = Jobs.find(params[:id])
  end

  def update
    @jobs = Jobs.find(params[:id])
    if @jobs.update_attributes(params[:jobs])
      flash[:notice] = 'Jobs was successfully updated.'
      redirect_to :action => 'show', :id => @jobs
    else
      render :action => 'edit'
    end
  end

  def destroy
    Jobs.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
