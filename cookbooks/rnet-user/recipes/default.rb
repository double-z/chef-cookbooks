users = data_bag("users")

users.each do |name|
  user(name) do
    home "/home/#{name}"
    supports :manage_home => true
  end
end

group "users" do
  gid 777
  members users
end
