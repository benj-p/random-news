class UpdateArticlesJob < ApplicationJob
  queue_as :default

  def perform
    TheConversation.new.update_db
    BBC.new.update_db
  end
end