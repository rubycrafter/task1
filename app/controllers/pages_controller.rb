class PagesController < ApplicationController

def index
end

def show
  @page = Page.find_by name: params[:path]
end

def new
  @page = Page.new
end

def create
  @page = Page.new(page_params)
  if @page.save
    redirect_to page_path(@page)
  else
    render "new"
  end
end

def edit
end

def update
end

def destroy
end

private
def page_params
  params.require(:page).permit!
end

def page_path(page)
  if page.suprapage.nil?
    return "/"+page.name
  else
    return "/"+page_path(page.suprapage)+"/"+page.name
  end
end

end
