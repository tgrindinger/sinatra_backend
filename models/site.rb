class Site
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :reserved_by, String
  property :lo_hostname, String
  property :description, String

  belongs_to :bus, required: false
  belongs_to :org, required: false
  has n, :users, constraint: :destroy
  has n, :installations, constraint: :destroy

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_format_of :name, with: /^[a-zA-Z0-9\.\_\-]+$/
  validates_uniqueness_of :org_id

  def self.filter_fields(data)
    valid_fields = ['id', 'name', 'reserved_by', 'lo_hostname', 'description', 'bus_id', 'org_id']
    data.keep_if {|k,v| valid_fields.include? k}
  end

  after :create, :create_users

  def create_users
    users = {user1: {user_name: "#{self.name}.user1@example.com",
                        profile: "User Profile 1"},
             user2: {user_name: "#{self.name}.user2@example.com",
                              profile: "User Profile 2"},
             user3: {user_name: "#{self.name}.user3@example.com",
                             profile: "User Profile 3"}
    }   
    users.each {|u| create_user(u.first, u.last)}
  end

  def create_user(user, values)
    User.create(user_name: values[:user_name],
                site_id: self.id,
                security_token: nil,
		first_name: self.name,
		last_name: user.to_s,
		password: "xxxxxxxx",
		email: "email@example.com",
		user1: (user == :user1),
		user2: (user == :user2),
		user3: (user == :user3),
		profile: values[:profile])
  end
  
  def user1 
    users.select{|u| u.profile == "User Profile 1"}.first
  end

  def make_login_url
    login_url = "https://example.com/"
    unless org_id.blank?
      org = Org.find_by(id: org_id)
      login_url = org.login_url if org && !org.login_url.blank?
    end
    "#{login_url}?un=#{user1.user_name}&pw=#{user1.password}"
  end

end	

