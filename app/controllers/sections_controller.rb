class SectionsController < ApplicationController
  before_action :logged_in_user
  # before_action :correct_user
  before_action :admin_user

  def index
    @sections = Section.order("position ASC")
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      flash[:success] = "New section created."
      redirect_to(:action => "index")
    else
      render("new")
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.new(section_params)
    if @section.update_attributes(section_params)
      flash[:success] = "Section updated successfully."
      redirect_to(:action => 'show', :id => @section.id)
    else
      render('edit')
    end
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy
    flash[:success] = "Section destroyed successfully."
    redirect_to(:action => 'index')
  end

  private

  def section_params 
      params.require(:section).permit(:page_id, :name, :position, :permalink, :visible, :content_type, :content)
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
