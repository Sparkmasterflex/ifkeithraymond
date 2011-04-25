# initial Admin user
puts "Creating User: admin"
puts "-------------------"
if User.find_by_login("keith").blank?
  user = User.create(
    :first_name            => "Keith",
    :last_name             => "Raymond",
    :email                 => "raymondke99@gmail.com",
    :login                 => "keith",
    :password              => "Sp@@d455",
    :password_confirmation => "Sp@@d455")
  puts "- User created. username: keith, password: Sp@@d455\n"
else
  puts "- User already exists.\n\n"
end