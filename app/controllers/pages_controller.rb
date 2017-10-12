class PagesController < ApplicationController
  before_action :logged_in_user
  # before_action :correct_user
  before_action :admin_user
  
  def index
    @pages = Page.order("position ASC")
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      flash[:success] = "New page created."
      redirect_to(:action => 'index')
    else
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.new(page_params)
    if @page.update_attributes(page_params)
      flash[:success] = "Page updated successfully."
      redirect_to(:action => 'show', :id => @page.id)
    else
      render('edit')
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    @page = Page.find(params[:id]).destroy
    flash[:success] = "Page destroyed successfully."
    redirect_to(:action => 'index')
  end

  private

  def page_params 
      params.require(:page).permit(:name, :subject_id, :position, :permalink, :visible)
  end


    # Before filters
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
