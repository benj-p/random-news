class NewsletterSubscriptionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :create ]

  def create
    @newsletter_subscription = NewsletterSubscription.new(review_params)
    respond_to do |format|
      if @newsletter_subscription.save
        format.turbo_stream
        format.html { redirect_to root_path, notice: "You've succesfully subscribed 😃" }
      else
        format.turbo_stream { render :subscription_errors }
        format.html { redirect_to root_path, notice: "There was an issue with your subscription 😕" }
      end
    end
  end
  
  private
  
  def review_params
    params.require(:newsletter_subscription).permit(:email)
  end
end
