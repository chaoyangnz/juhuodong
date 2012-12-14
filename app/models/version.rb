class Version < ActiveRecord::Base
  belongs_to :versionable, :polymorphic => true

  serialize :data

  after_create :publish_if_certified
  after_update :sync_if_approved


  def self.last
    order('version desc').first
  end

  def self.size
    count
  end

  def self.has_version?
    count == 0
  end

  def self.previous(version)
    (version < 1) ? nil : where(:version => version-1)
  end

  def self.next(version)
    (version > size) ? nil : where(:version => version+1)
  end
end