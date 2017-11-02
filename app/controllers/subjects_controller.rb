class SubjectsController < ApplicationController
  before_action :logged_in_user
  # before_action :correct_user
  before_action :admin_user, only: [:new, :edit, :update, :destroy]

  def index
    #@users = User.all
    @subjects = Subject.order("position ASC")
  end

  def show
    #@user = User.find(params[:id])
    @subject = Subject.find(params[:id])
    if @subject.nil?
      redirect_to(:action => 'index')
    end
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      flash[:success] = "New subject created."
      redirect_to subjects_url
    else
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
    @subject = Subject.find(params[:id])
    if @subject.update_attributes(subject_params)
      redirect_to(:action => 'show', :id => @subject.id )
    else
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
    flash[:success] = "Subject deleted successfully."
    redirect_to(:action => 'index')
  end

  private
  def subject_params
    params.require(:subject).permit(:name, :position, :visible)
  end

      # Before filters
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    #def correct_user
    #  @user = User.find(params[:id])
    #  redirect_to(root_url) unless current_user?(@user)
    #end

    def admin_user
      redirect_to(root_url) unless current_user.admin? 
    end
end
