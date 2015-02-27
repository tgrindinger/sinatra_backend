class Installation
  include DataMapper::Resource

  property :id, Serial
  property :site_id, Integer, unique_index: :index_site_scheduled_package
  property :scheduled_package_id, Integer, unique_index: :index_site_scheduled_package

  belongs_to :site
  belongs_to :installed_package, 'Package'
  belongs_to :scheduled_package, 'Package'

  validates_presence_of :scheduled_package_id

  def self.filter_fields(data)
    valid_fields = ['id', 'site_id', 'installed_package_id', 'scheduled_package_id']
    data.keep_if {|k,v| valid_fields.include? k}
  end

end	

