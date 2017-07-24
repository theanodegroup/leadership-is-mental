module PagesHelper
  def nav_item(name, path)
    content_tag(:li, role: 'presentation', class: request.path == path ? 'active' : '') do
      link_to name, path
    end
  end
end
