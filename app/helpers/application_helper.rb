# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def delete_item_link(controller, item)
    link_to 'Delete',
            { :controller => controller,
              :action => "destroy",
              :id => item.id }, 
            :confirm => "Really delete the #{item.class.class_name}?",
            :method => :delete,
            :post => true
  end
  
end
