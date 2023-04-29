namespace :comment do
  desc "comment approval task"
  task approve: :environment do
    Comment.where('created_at < ?', 15.minute.ago).update_all(approved: true)
  end
end
