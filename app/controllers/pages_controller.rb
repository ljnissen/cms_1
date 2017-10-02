class PagesController < ApplicationController
  
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
      redirect_to(:action => 'show', :id => @page.id)
    else
      render('new')
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to(:action => 'index')
  end

  private

  def page_params 
      params.require(:subject).permit(:name, :subject_id, :position, :permalink, :visible)
  end
end
