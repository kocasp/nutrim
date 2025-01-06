require 'csv'

puts "Loading products from CSV..."

return puts "Products already exist in database, skipping seed" if Product.count > 0

count = 0
total_rows = CSV.read(Rails.root.join('db/db.csv')).length
CSV.foreach(Rails.root.join('db/db.csv'), headers: false) do |row|
  Product.create!(
    name: row[1],
    brand: row[2],
    kcal: row[3],
    fat: row[4], 
    carbs: row[5],
    protein: row[6],
    source: row[7],
  )
  count += 1
  puts "Processed #{(count.to_f / total_rows * 100).round(1)}% (#{count}/#{total_rows} products)..." if count % 100 == 0
end
puts "Created #{Product.count} products"