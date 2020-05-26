# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
    name: "RAD",
    email: "rad2020rmit@gmail.com",
    password: "Rails2020",
    password_confirmation: "Rails2020",
    phone: "123456789012",
    admin: true
)

Topic.create( 
 [  
{name: 'V.R.' }, 
{name: 'A.I.' }, 
{name: 'RMIT' }, 
{name: 'Java' },
{name: 'Game' }, 
{name: 'Rails' }, 
{name: 'Go' }, 
{name: 'Web' },
{name: 'M.L.' },
{name: 'Joke' }, 
{name: 'Reat' }, 
{name: 'Vue' }, 
{name: 'Node' },
{name: 'iOS' },
{name: 'AWS' },
{name: 'News'}
 ])