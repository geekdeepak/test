module NavigationHelper

  def life_nav(user)
    # Top of page navigation
    if user
      result = "<h1>" + breadcrumbs + "</h1>"
      result += '<ul class="subnav">'
        has_life = @life && !@life.new_record?
        result += '<li>'+link_to_unless_cont( "projects", "Projects", life_projects_path(@life) )+'</li>' if has_life
        result += '<li>'+link_to_unless_cont( "projects", "Projects", projects_path )+'</li>' if !has_life
        result += '<li>'+link_to_unless_cont( "tasks", "Steps", life_tasks_path(@life) )+'</li>' if has_life
        result += '<li>'+link_to_unless_cont( "tasks", "Steps", tasks_path )+'</li>' if !has_life
        result += '<li>'+link_to_unless_cont( "contacts", "Contacts", life_contacts_path(@life) )+'</li>' if has_life
        result += '<li>'+link_to_unless_cont( "contacts", "Contacts", contacts_path )+'</li>' if !has_life
        result += '<li>'+link_to_unless_cont( "profiles", "Profiles", show_life_profile_path(@life) )+'</li>' if has_life || @profile
        result += '<li>'+link_to_unless_cont( "profiles", "Profiles", profiles_path )+'</li>' if !has_life && !@profile
      result += '</ul>'
    end
  end
  
  def link_to_unless_cont (controller, title, link)
    if controller == params[:controller]
      link_to( title, link, :class => "selected" )
    else
      link_to( title, link )
    end
  end
  
  def current_projects
    # projects list on side of page
    @projects.empty? && @life ? @life.projects : @projects
  end
  
  def breadcrumbs
    if @life && !@life.new_record?
      result = @life.name
      result += "<small> | "
        result += link_to 'Edit', edit_life_path(@life)
        result += " | "
        result += delete_item_link("lives", @life)
      result += "</small>"
    else
      "All Profiles"
    end
  end
end
