# -*- encoding : utf-8 -*-
class Event < ActiveRecord::Base
  #-------------------------------------------------------
  # CONSTANTS define, avoid Million-Model march
  #-------------------------------------------------------
  CATEGORIES = ['职场/商务', '沙龙/讲座', '电影', '会议培训', '节庆/集会', '聚会/派对', '运动健身', '户外/旅游', '公益/环保', '会展/博览', '音乐/演出', '艺术/表演']
  STATUS = ['draft', 'approving', 'published', 'cancelled']
  #           |----> cancelled
  #   draft ------> published ---------------> （finished）
  #                             |-----> suspended
  # 对于非认证的组织发布的活动需要审批
  APPROVE_STATUS = ['pending', 'approved', 'reject']

  STATUS.each do |status|
    define_method "#{status}?" do
      self.status == status
    end
  end

  #------------------------------------------------------
  # Relations assiacation
  #------------------------------------------------------
  belongs_to :user
  belongs_to :host
  has_many :tags, :as => :taggable
  has_many :tickets
  has_many :fields, :as => :fieldable

  has_many :versions, :as => :versionable

  accepts_nested_attributes_for :tickets

  #-----------------------------------------------------
  # Mass assignments
  #-----------------------------------------------------
  attr_accessible :name, :start_time, :end_time, :province, :city, :address,
                  :size, :category, :host_id, :banner,
                  :detail, :seller_name, :seller_email, :seller_telephone,
                  :short_url, :site_url, :notice, :tag_names
  attr_accessible :tickets_attributes

  #-----------------------------------------------------
  # Validations
  #-----------------------------------------------------
  validates :name, :presence => true
  validates :start_time, :presence => true
  validates :end_time, :presence => true
  validates :province, :presence => true
  validates :city, :presence => true
  validates :address, :presence => true
  validates :category, :presence => true, :inclusion => {:in => CATEGORIES }
  validates :detail, :presence => true
  validates :banner, :presence => true
  validates :host_id, :presence => true
  validates :size, :presence => true
  validates :seller_name, :presence => true
  validates :seller_telephone, :presence => true

  def tag_names
    @tag_names || tags.map {|tag| tag.name}.join(',')
  end

  def tag_names= tag_names
    @tag_names = tag_names
  end

  #-----------------------------------------------------
  # Lifecycle callbacks
  #-----------------------------------------------------
  after_create :save_tags

  def save_tags
    unless @tag_names.empty?
      @tag_names.split(",").each do |name|
        self.tags.create(:name => name.lstrip.rstrip)
      end
    end
  end

  # Business Logic
  class << self
    def create_draft_by_user event
      event.id = Event.connection.select_value("SELECT nextval('events_id_seq')")
      version = event.versions.new
      version.data = event
      version.status = 'draft'
      version.save!
    end

    def create_publish_by_user event

      if event.host.certified?
        event.status = 'published'
        event.save!
      else
        event.id = Event.connection.select_value("SELECT nextval('events_id_seq')")
        version = event.versions.new
        version.data = event
        version.status = 'pending'
        version.save!
      end
    end

    def draft_publish version
      Event.transaction do
        version.status = 'pending'
        version.save!
      end
    end

    def approve event
      Event.transaction do
        event.update_attributes!(:approve_flag => '0')
        version = event.versions.last
        version.status = 'approved'
        version.save!
      end
    end

    def reject event
      Event.transaction do
        event.update_attributes!(:approve_flag => '0')
        version = event.versions.last
        version.status = 'rejected'
        version.save!
      end
    end


  end
end
