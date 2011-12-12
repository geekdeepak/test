class TaskLog < ActiveRecord::Base
    belongs_to :task
    belongs_to :user
    
    def user_name
    	User.find(self.user_id).name
    end
end
