class UpdateArticlesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    TheConversation.new.update_db
  end
end