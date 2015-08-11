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

def show_content(page)
  html_code = page.content
  html_code.gsub!(/\*\*(?<bold>.*)\*\*/, '<b>\k<bold></b>')
  html_code.gsub!(/\\\\(?<ital>.*)\\\\/, '<i>\k<ital></i>')
  html_code.gsub!(/\(\((?<link>.*) (?<name>.*)\)\)/, '<a href="/\k<link>">\k<name></a>') 

  return html_code.html_safe
end

end
