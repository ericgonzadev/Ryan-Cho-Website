class PagesController < ApplicationController
  def index
    @information = Information.first
  end
end
