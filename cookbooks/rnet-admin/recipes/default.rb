admins = data_bag("admins")

admins.each do |name|
  user(name) do
    action :create
    home "/home/#{name}"
    system true
    supports :manage_home => true
  end
end

group "admins" do
  gid 999
  members admins
end
