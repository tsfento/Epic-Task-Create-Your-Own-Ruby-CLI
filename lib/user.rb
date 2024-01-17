require 'bcrypt'
require 'json'

class User
  attr_accessor :username, :password

  @@users = []

  def initialize(username, password, existing_hash = false)
    @username = username
    @password = existing_hash ? BCrypt::Password.new(password) : BCrypt::Password.create(password)

    @@users << self
  end

  def self.all
    @@users
  end

  def self.authenticate(username, password)
    user = User.find_by_username(username)

    user if user && user.password == password
  end

  def self.find_by_username(username)
    user = all.find do |user|
      user.username == username
    end
  end

  def self.store_credentials(user)
    file_path = 'users.json'

    File.open(file_path, 'w') { |file| file.write(JSON.generate([])) } unless File.exist?(file_path)

    file = File.read(file_path)
    users_data = JSON.parse(file)

    users_data << { username: user.username, password: user.password }

    File.open(file_path, 'w') { |file| file.write(JSON.generate(users_data)) }
  end

  def self.update_credentials(user)
    file_path = 'users.json'

    File.open(file_path, 'w') { |file| file.write(JSON.generate([])) } unless File.exist?(file_path)

    file = File.read(file_path)
    users_data = JSON.parse(file)

    user_index = users_data.index { |u| u['username'] == user.username }

    users_data[user_index]['password'] = BCrypt::Password.create(user.password)

    File.open(file_path, 'w') { |file| file.write(JSON.generate(users_data)) }
  end

  def self.load_users_from_file
    file_path = 'users.json'

    if File.exist?(file_path)
      file = File.read(file_path)

      users_data = JSON.parse(file)

      users_data.each do |user_data|
        User.new(user_data['username'], user_data['password'], true)
      end
    end
  end

  def self.reset_password(username, new_password)
    user = find_by_username(username)
    user.password = new_password

    update_credentials(user)
  end
end
