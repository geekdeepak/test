module TasksHelper
  def profile_list(task)
    profiles = []
    task.lives.each do |life|
      profiles << life.profile
    end
    profiles.map(&:name).join(', ').strip
  end
end
