class PagesController < ApplicationController
helper_method :page_path

def index
end

def show
  @page = find_page_by_full_path(params[:path])
end

def new
  @page = Page.new
end

def create
  @page = Page.new(page_params)
  @page.suprapage = Page.find_by name: parse_page_name(params[:path]).last
  @page.suprapage ||= Page.first
  # Here should be root page existance validation throu exception
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
  if page.suprapage.id == Page.first.id
    return "/"+page.name
  else
    return page_path(page.suprapage)+"/"+page.name
  end
end

def parse_page_name(path)
  path ||= ""
  pages_array = path.split("/")

  # Here should be some validatios

  return pages_array
end

def find_page_by_full_path(name)
  path = parse_page_name(name)
  page = Page.first
  for i in (0...path.size)
    page = page.subpages.find_by name: path[i]
  end
  return page

end


end
