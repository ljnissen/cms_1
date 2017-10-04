class SectionsController < ApplicationController
  def index
    @sections = Section.order("position ASC")
  end

  def show
  end

  def new
  end

  def edit
  end

  def delete
  end
  private

  def section_params 
      params.require(:section).permit(:page_id, :name, :position, :permalink, :visible, :content_type, :content)
  end
end
