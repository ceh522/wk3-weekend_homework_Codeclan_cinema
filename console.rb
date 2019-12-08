require_relative( 'models/customer' )
require_relative( 'models/film' )
require_relative( 'models/ticket' )

require('pry')

Ticket.delete_all
Customer.delete_all
Film.delete_all



film1 = Film.new({'title' => 'Fantastic Beasts 3', 'price' => 5})
film2 = Film.new({'title' => 'A Christmas Carol', 'price' => 3})

film1.save
film2.save

customer1 = Customer.new({'name' => 'Catherine', 'funds' => 15})
customer2 = Customer.new({'name' => 'Danny', 'funds' => 20})
customer3 = Customer.new({'name'=> 'Tammy', 'funds' => 30})

customer1.save
customer2.save
customer3.save

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id})
ticket3 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id})
ticket4 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
ticket5 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film2.id})

ticket1.save
ticket2.save
ticket3.save
ticket4.save
ticket5.save

binding.pry
nil
