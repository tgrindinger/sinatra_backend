class Org
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :sf_org_id, String
  property :login_url, String
  property :last_reload, DateTime
  property :last_renew, DateTime
  property :lock, String

  has 1, :site
  has 1, :install_user, constraint: :destroy
  has 1, :source_org, 'Org'
  belongs_to :source_org, 'Org', required: false

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_format_of :name, with: /^[a-zA-Z0-9\.\_\-]+$/

  after :create, :create_install_user

  def self.filter_fields(data)
    valid_fields = ['id', 'name', 'sf_org_id', 'login_url',
                    'last_reload', 'last_renew', 'lock', 'source_org_id']
    data.keep_if {|k,v| valid_fields.include? k}
  end

  def self.create(data)
    data['last_reload'] ||= DateTime.now - 2
    data['last_renew'] ||= DateTime.now - 2
    data['lock'] = nil if data['lock'] == ""
    super
  end

  def self.update(data)
    data['lock'] = nil if data['lock'] == ""
    super
  end

  def self.available_sandboxes
    Org.all(:lock => nil,
            :source_org_id.not => nil, 
            Org.source_org.lock => nil,
            :last_reload.lt => (DateTime.now - 1), 
            site: nil, 
            order: [ :last_reload.asc ])
  end

  def create_install_user
    InstallUser.create(user_name: self.source_org ? "#{self.source_org.name}@example.com.#{self.name}" :
                                                    "#{self.name}@example.com",
                       org_id: self.id,
                       security_token: nil,
                       first_name: "first_name",
                       last_name: "last_name",
                       password: "xxxxxxxx",
                       email: "email@example.com")
  end

end	

