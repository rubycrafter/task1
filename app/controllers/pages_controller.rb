class PagesController < ApplicationController
helper_method :page_path

def index
  init_tree if Page.all.empty?
end

def show
  @page = find_page_by_full_path(params[:path])
end

def new
  @page = Page.new
end

def create
  @page = Page.new(page_params)
  # @page.suprapage = Page.find_by name: parse_page_name(params[:path]).last
  @page.suprapage = find_page_by_full_path(params[:path])
  @page.suprapage ||= Page.first
  # Here should be root page existance validation by exception
  if @page.save
    redirect_to page_path(@page)
  else
    render "new"
  end
end

def edit
  @page = find_page_by_full_path(params[:path])
end

def update
  @page = find_page_by_full_path(params[:path])
  @page.update_attributes(page_params)
  if @page.errors.empty?
    redirect_to page_path(@page)
  else
    render "edit"
  end
end

def destroy
end


private
# Function which can give
# params[:page] to controller
def page_params
  params.require(:page).permit!
end

# Function takes a node as argument
# and returns a string path to it
def page_path(page)
  if page.suprapage.id == Page.first.id
    return "/"+page.name
  else
    return page_path(page.suprapage)+"/"+page.name
  end
end

# Function takes a string
# and parse it into array of nodes
def parse_page_name(path)
  path ||= ""
  pages_array = path.split("/")

  # Here should be some validatios

  return pages_array
end

# Function takes a string - path to node,
# and returns a node object
def find_page_by_full_path(name)
  path = parse_page_name(name)
  page = Page.first
  for i in (0...path.size)
    page = page.subpages.find_by name: path[i]
  end
  return page
end

# Function initialize a tree root - 
# node with id: 1 and name: ""
# This node is not modifiable.
def init_tree
  Page.delete_all
  @root = Page.new(name: "")
  @root.save(validate: false)
  # Yes, it works by ignoring validations =)
end


end
