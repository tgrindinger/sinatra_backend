class Bus
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :url, String

  has n, :site

  validates_presence_of :name
  validates_format_of :name, with: /^[a-zA-Z0-9\.\_\-]+$/
  validates_uniqueness_of :name

  def self.filter_fields(data)
    valid_fields = ['id', 'name', 'url']
    data.keep_if {|k,v| valid_fields.include? k}
  end

end	

