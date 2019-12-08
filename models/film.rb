require('pg')
require_relative('../db/sql_runner')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films
    (
      title,
      price
    )
    VALUES(
      $1, $2)
      RETURNING id;"
      values = [@title, @price]
      film = SqlRunner.run(sql, values)[0]
      @id = film['id'].to_i
    end

    def self.all()
      sql = "SELECT * FROM films;"
      films = SqlRunner.run(sql)
      return films.map{ |film| Film.new(film)}
    end

    def update()
      sql = "UPDATE films SET (
      title,
      price,
      ) =
      (
        $1, $2,
      )
      WHERE id = $3"
      values = [@title, @price, @id]
    end

    def self.delete_all()
      sql = "DELETE FROM films;"
      SqlRunner.run(sql)
    end

    def delete()
      sql = "DELETE FROM films WHERE id = $1"
      values = [@id]
      SqlRunner.run(sql,values)
    end

    def customers_with_tickets_for_film
      sql = "SELECT customers.* FROM customers
      INNER JOIN tickets
      ON tickets.customer_id = customers.id
      WHERE film_id = $1;"
      values = [@id]
      results = SqlRunner.run(sql, values)
      return results.map{ |hash| Customer.new(hash) }
    end

    def number_of_customers_with_tickets_for_film
      sql = "SELECT customers.* FROM customers
      INNER JOIN tickets
      ON tickets.customer_id = customers.id
      WHERE film_id = $1;"
      values = [@id]
      results = SqlRunner.run(sql, values)
      number_of_tickets_sold_for_film = results.map{ |hash| Customer.new(hash) }
      return number_of_tickets_sold_for_film.count
    end


  end
