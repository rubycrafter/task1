module PagesHelper

# This helper will build a tree
# of a 'page' node
def show_tree(page)
  # Condition out of recurtion
  return "" if page.subpages.empty?

  # Creating a tree as table
  tree = "<ul>"
  page.subpages.each do |p|
    tree += '<li>' + link_to(p.name, p) + '</li>'
    tree += show_tree(p)
  end
  tree += "</ul>"
  # Closing a table and
  # returns tree as html safe code
  return tree.html_safe
end

end
