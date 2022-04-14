class StaticPagesController < ApplicationController
  def home
    return unless logged_in?

    @micropost = current_user.microposts.build
    @pagy, @feed_items = pagy current_user.microposts,
                              items: Settings.settings.item_per_page
  end

  def help; end

  def about; end

  def contact; end
end
