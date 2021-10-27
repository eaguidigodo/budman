# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
User.create!(name: "admin",
            email: "admin@admin.com",
            password: "adminpass",
            password_confirmation: "adminpass",
            admin: true
)

User.create!(name: "user",
            email: "user@user.com",
            password: "userpass",
            password_confirmation: "userpass",
            admin: false
)
10.times do |n|
            name = Faker::Games::Pokemon.name
            email = Faker::Internet.email
            password = "userpassword"
            User.create!(name: name,
                        email: email,
                        password: password,
                        password_confirmation: password,
                        admin: false
            )
end

10.times do |n|
    
    start_date= Date.today
    end_date = Date.today
    amount =  Faker::Number.number(digits: 7)
    Budget.create!(start_date: start_date,
                end_date: end_date,
                amount: amount,
                user_id: 1
    )
end

9.times do |n|
    
    budget_id = n+1
    name =  Faker::Commerce.color
    amount = Faker::Number.number(digits: n)
    priority = "Very importatnt"
    Need.create!(name: name,
                amount: amount,
                priority: priority,
                budget_id: budget_id
    )
end

9.times do |n|
    
    day = "wednesday"
    budget_id = n+1
    date = Date.today
    need =  Faker::Food.ingredient
    description =  Faker::Food.description
    amount = Faker::Number.number(digits: 3)
    Expense.create!(day: day,
                date: date,
                amount: amount,
                description: description,
                need: need,
                budget_id: budget_id
    )
end