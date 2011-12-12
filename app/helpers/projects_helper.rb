module ProjectsHelper

  def complete_to_percent(project)
    number_to_percentage(project.completion*100, :precision => 1)
  end

  def total_complete(project)
    project.tasks.completed.count.to_s + "/" + project.tasks.count.to_s
  end
  
  def next_task(project)
    tasks = []
    tasks.sort {|a,b| a.due <=> b.due}
    task = tasks.first
    task.nil? ? "&nbsp;" : link_to( truncate(task.name,:length => 20,:omission => "..."), task ) + "<br />" + task.due_date_time.to_s
  end
  
end
