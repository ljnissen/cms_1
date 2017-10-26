class SectionsController < ApplicationController
  before_action :logged_in_user
  # before_action :correct_user
  before_action :admin_user
  before_action :find_page

  def index
    @sections = Section.where(:page_id => @page.id).order('position ASC')
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new({:page_id => @page.id})
    @pages = @page.subject.pages.order('position ASC')
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      flash[:success] = "New section created."
      redirect_to(:action => "index", :page_id => @page.id)
    else
      @pages = Page.order('position ASC')
      render("new")
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
      flash[:success] = "Section updated successfully."
      redirect_to(:action => 'show', :id => @section.id, :page_id => @page.id)
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
    redirect_to(:action => 'index', :page_id => @page.id)
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

    def find_page
      if params[:page_id]
        @page = Page.find(params[:page_id])
      end
    end
end
