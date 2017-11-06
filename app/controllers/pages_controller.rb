class PagesController < ApplicationController
  before_action :logged_in_user
  # before_action :correct_user
  before_action :admin_user, only: [:show, :edit, :update, :destroy]
  before_action :find_subject, only: [:index, :show, :new, :create, :edit, :update, :delete]

  
  def index
   # @pages = Page.order('position ASC')
   @pages = Page.where(:subject_id => @subject.id).order("position ASC")
   #@pages = @subject.pages.order("position ASC")

  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new({:subject_id => @subject.id})
    @subjects = Subject.order('position ASC')
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      flash[:success] = "New page created."
      redirect_to(:action => 'index', :subject_id => @subject.id)
    else
      @subjects = Subject.order('position ASC')
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
    @subjects = Subject.order('position ASC')
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:success] = "Page updated successfully."
      redirect_to(:action => 'show', :id => @page.id, :subject_id => @subject.id)
    else
      @subjects = Subject.order('position ASC')
      render('edit')
    end
  end

  def delete
    @page = Page.find(params[:id])
    render 'delete'
  end

  def destroy
    page = Page.find(params[:id])
        page.destroy
        flash[:success] = "Page deleted successfully."
        redirect_to(:back)
        
  end

  private

  def page_params 
      params.require(:page).permit(:name, :subject_id, :position, :permalink, :visible, subjects_attributes: [:name, :position, :visible ])
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

    def find_subject
      if params[:subject_id]
        @subject = Subject.find(params[:subject_id])
      end
    end
end
