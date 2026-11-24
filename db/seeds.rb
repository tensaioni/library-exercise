# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
[ [ "Some title", "Some author", "123456" ], [ "Other title", "Other author", "654321" ] ].each do |title, author, serial_number|
  Book.find_or_create_by!(title: title, author: author, serial_number: serial_number)
end

[ [ "Some name", "someemail@example.com", "123456" ], [ "Other name", "otheremail@example.com", "654321" ] ].each do |name, email, library_card_number|
  Reader.find_or_create_by!(name: name, email: email, library_card_number: library_card_number)
end
