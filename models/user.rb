class User
  include DataMapper::Resource

  property :id, Serial
  property :user_name, String
  property :profile, String
  property :security_token, String
  property :first_name, String
  property :last_name, String
  property :password, String
  property :email, String
  property :user1, Boolean
  property :user2, Boolean
  property :user3, Boolean

  belongs_to :site

  validates_presence_of :user_name
  validates_uniqueness_of :user_name
  validates_format_of :user_name, with: /^[a-zA-Z0-9\.\_\-\@]+$/

  def self.filter_fields(data)
    valid_fields = ['id', 'user_name', 'profile', 'security_token', 'first_name', 'last_name',
                    'password', 'email', 'user1', 'user2', 'user3', 'site_id']
    data.keep_if {|k,v| valid_fields.include? k}
  end

end	

