class PagesController < ApplicationController
  def index
    @information = Information.first
    @freelance_work = Project.retrieve_projects("Freelance Work")
    @portfolio = Project.retrieve_projects("Portfolio")
    @message = Message.new
  end
end
