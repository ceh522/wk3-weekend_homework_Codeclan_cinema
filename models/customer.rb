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









end
