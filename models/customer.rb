require('pg')
require_relative('../db/sql_runner')

attr_reader :id
attr_accessor :name, :funds


class Customer

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
      star = SqlRunner.run(sql, values)[0]
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


  end
