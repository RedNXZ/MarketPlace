OrderItem.delete_all
Order.delete_all
Product.delete_all
Category.delete_all
User.delete_all

# Создаем пользователей
User.create!(
  name: "Админ",
  email: "admin@example.com",
  password: "password123",
  password_confirmation: "password123"
)

# Создаем категории
cat1 = Category.create!(name: "Электроника")
cat2 = Category.create!(name: "Одежда")
cat3 = Category.create!(name: "Книги")

# Создаем товары
Product.create!([
                  { name: "Смартфон", description: "Современный смартфон с большим экраном", price: 25000, category: cat1 },
                  { name: "Ноутбук", description: "Мощный ноутбук для работы и игр", price: 55000, category: cat1 },
                  { name: "Футболка", description: "Удобная хлопковая футболка", price: 1500, category: cat2 },
                  { name: "Джинсы", description: "Стильные джинсы скинни", price: 3500, category: cat2 },
                  { name: "Роман 'Война и мир'", description: "Классика русской литературы", price: 800, category: cat3 },
                  { name: "Детектив", description: "Увлекательный детективный роман", price: 600, category: cat3 }
                ])

puts "Seed успешно загружен!"