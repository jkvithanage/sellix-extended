class PagesController < ApplicationController
  layout "landing_page"
  def index
    render :index
  end
end
