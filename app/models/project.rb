class Project < ApplicationRecord

  require 'net/http'
  require 'json'

  default_scope -> { order(order_listed: :asc) }
  before_validation :order_listed_is_num
  validates :title, presence: true
  validates :link, presence: true
  before_save :set_video_id_and_thumbnail

  # Retrieves projects based on their work_type value
  def Project.retrieve_projects(work_type)
    Project.where("work_type = ?", work_type)
  end

  # When project is created, the projects after it have their order attribute incremented by 1
  def Project.create_increment_order(project_id, project_order, work_type)
    Project.where("work_type = ? AND order_listed >= ? AND id != ?", work_type, project_order, project_id).update_all("order_listed = order_listed + 1")
  end

  # When project is edited, the projects after it have their order attribute incremented by 1
  def Project.update_increment_order(project_id, project_order, cache_order, work_type, cache_work_type)
    if cache_work_type == work_type
      if project_order < cache_order
        Project.where("work_type = ? AND order_listed >= ? AND order_listed < ? AND id != ?", work_type, project_order, cache_order, project_id).update_all("order_listed = order_listed + 1")
      elsif project_order > cache_order
        Project.where("work_type = ? AND order_listed <= ? AND order_listed > ? AND id != ?", work_type, project_order, cache_order, project_id).update_all("order_listed = order_listed - 1")
      end
    elsif cache_work_type != work_type
      if project_order <= cache_order
        Project.where("work_type = ? AND order_listed >= ? AND id != ?", work_type, project_order, project_id).update_all("order_listed = order_listed + 1")
        Project.where("work_type = ? AND order_listed > ? AND id != ?", cache_work_type, cache_order, project_id).update_all("order_listed = order_listed - 1")
      elsif project_order >= cache_order
        Project.where("work_type = ? AND order_listed >= ? AND id != ?", work_type, project_order, project_id).update_all("order_listed = order_listed - 1")
        Project.where("work_type = ? AND order_listed > ? AND id != ?", cache_work_type, cache_order, project_id).update_all("order_listed = order_listed - 1")
      end
    end 
      
  end

  # When a project is deleted, the projects after it have their order_listed attribute decremnted by 1
  def Project.decrement_order(project_id, project_order, work_type)
    Project.where("work_type = ? AND order_listed > ? AND id != ?", work_type, project_order, project_id).update_all("order_listed = order_listed - 1")
  end

  # When a project is ready to be saved, the video_id_and_thumbnail are set
  def set_video_id_and_thumbnail
    if self.video_source == "YouTube"
      if self.link.include?("watch?v=")
        self.video_id = self.link.split("=")[1]
      elsif self.link.include?("youtu.be/")
         self.video_id = self.link.split("/").last
      end
      self.link = "https://youtu.be/#{self.video_id}"
      self.thumbnail = "https://img.youtube.com/vi/#{self.video_id}/maxresdefault.jpg"
    else
      self.video_id = self.link.split("/").last
      url = "https://vimeo.com/api/v2/video/#{self.video_id}.json"
      uri = URI(url)
      response = Net::HTTP.get(uri)
      json_data = JSON.parse(response)
      self.thumbnail = json_data[0]["thumbnail_large"]
    end
  end

  def order_listed_is_num
    if self.order_listed <= 0
      errors.add(:order, "field should be a number greater than 0")
    end
  end

end
