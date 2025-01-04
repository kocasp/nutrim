require 'csv'

puts "Loading products from CSV..."

return puts "Products already exist in database, skipping seed" if Product.count > 0

count = 0
total_rows = CSV.read(Rails.root.join('db/db.csv')).length
CSV.foreach(Rails.root.join('db/db.csv'), headers: false) do |row|
  Product.create!(
    id: row[0],
    url_id: row[1],
    name: row[2],
    kcal: row[3],
    protein: row[4], 
    carbs: row[5],
    fat: row[6],
    fiber: row[7]
  )
  count += 1
  puts "Processed #{(count.to_f / total_rows * 100).round(1)}% (#{count}/#{total_rows} products)..." if count % 100 == 0
end
puts "Created #{Product.count} products"