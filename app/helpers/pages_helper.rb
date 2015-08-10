module PagesHelper

def show_tree(page)
  return "" if page.subpages.empty?
  @@i ||= -1
  @@i += 1
  tree = "<ul>"
  page.subpages.each do |p|
    tree += '<li>' + link_to(p.name, p) + '</li>'
    tree += show_tree(p)
  end
  tree += "</ul>"
  return tree.html_safe
end

end
