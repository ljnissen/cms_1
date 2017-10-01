class SubjectsController < ApplicationController
  def index
    @subjects = Subject.order("position ASC")
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      redirect_to(:action => 'index')
    else
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
    @subject = Subject.new(subject_params)
    if @subject.update_attributes(subject_params)
      redirect_to(:action => 'show', :id => @subject.id )
    else
      render('edit')
    end
  end

  def delete
  end

  def destroy
  end

  private
  def subject_params
    params.require(:subject).permit(:name, :position, :visible)
  end
end
