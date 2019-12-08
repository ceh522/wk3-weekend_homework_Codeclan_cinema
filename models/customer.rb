require('pg')
require_relative('../db/sql_runner')
require_relative( './film' )

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers
    (
      name,
      funds
    )
    VALUES(
      $1, $2)
      RETURNING id;"
      values = [@name, @funds]
      customer = SqlRunner.run(sql, values)[0]
      @id = customer['id'].to_i
    end

    def self.all()
      sql = "SELECT * FROM customers;"
      customers = SqlRunner.run(sql)
      return customers.map{ |customer| Customer.new(customer)}
    end

    def update()
      sql = "UPDATE customers SET (
      name,
      funds,
      ) =
      (
        $1, $2,
      )
      WHERE id = $3"
      values = [@name, @funds, @id]
    end

    def self.delete_all()
      sql = "DELETE FROM customers;"
      SqlRunner.run(sql)
    end

    def delete()
      sql = "DELETE FROM customers WHERE id = $1"
      values = [@id]
      SqlRunner.run(sql,values)
    end

    def films_customer_has_tickets_for
      sql = "SELECT films.* FROM films
      INNER JOIN tickets
      ON tickets.film_id = films.id
      WHERE customer_id = $1;"
      values = [@id]
      results = SqlRunner.run(sql, values)
      return results.map{ |hash| Film.new(hash) }
    end

    def number_of_films_customer_has_tickets_for
      sql = "SELECT films.* FROM films
      INNER JOIN tickets
      ON tickets.film_id = films.id
      WHERE customer_id = $1;"
      values = [@id]
      results = SqlRunner.run(sql, values)
      number_of_films_customer_has_tickets_for = results.map{ |hash| Film.new(hash) }
      return number_of_films_customer_has_tickets_for.count
    end

    def customer_funds_reduced_to_pay_for_film_ticket
      sql = "SELECT films.* FROM films
      INNER JOIN tickets
      ON tickets.film_id = films.id
      WHERE customer_id = $1;"
      values = [@id]
      results = SqlRunner.run(sql, values)
      film_tickets_bought = results.map{ |hash| Film.new(hash) }
      for film in film_tickets_bought
        cost_of_films = film.price
        @funds = @funds - cost_of_films
      end
    end

  end
