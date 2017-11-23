crumb :root do
  link "Home", root_path
end

# Auto Generate the more straightforward breadcrumbs
[
  :about, :blog, :newsletter_signup, :what_you_get,
  :leadership_jobs, :events, :free_ebook, :disclaimer,
  :legal, :terms_of_use, :sitemap, :news, :articles
].each do |breadcrumb|
  crumb breadcrumb do
    link breadcrumb.to_s.titleize, polymorphic_path(breadcrumb)
  end
end

crumb :contact_us do
  link "Contact", contact_us_path
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).