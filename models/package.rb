class Package
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :version, String
  property :url, String
  property :release, Boolean
  property :namespace, String
  property :active, Boolean

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_format_of :name, with: /^[a-zA-Z0-9\.\_\-]+$/

  def self.filter_fields(data)
    valid_fields = ['id', 'name', 'version', 'url', 'release', 'namespace', 'active']
    data.keep_if {|k,v| valid_fields.include? k}
  end

end	

