class InformationController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate
  
  def index
    @information = Information.first
  end

  def edit
    @information = Information.first
  end

  def update
    @information = Information.find(params[:id])
    @information.update(information_params)
    redirect_to information_index_path
  end

private

  def information_params
    params.require(:information).permit(:name, :headline, :headline_description, 
      :about_me, :contact_description, :email, :phone, :quote, :facebook, 
      :instagram, :twitter, :linkedin, :vimeo, :youtube, :about_image, :resume)
  end

end
