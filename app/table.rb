require 'json'
require_relative 'cache'

class Table

  attr_reader :id
  def initialize(settings, id, query = {})
    @id = id
    @cache = Cache.new(settings)
    @query = query
  end

  def description
    table_data['description']
  end

  def measure_unit
    scheme = table_data['scheme']

    mu = 'Unitate de masura'
    scheme.each_pair do |column_name, values|
      if column_name.start_with?('UM:')
        mu = values.keys.first
      end
    end

    mu
  end

  def columns_with_selected_values
    rez = {}
    columns.each_pair do |column, row_and_index|
      rez[column] = row_and_index[:row]
    end
    rez
  end

  def query
    columns.values.collect {|row_and_index| row_and_index[:index]}.join(':')
  end

  def csv
    csv = @cache.get(id, query)
    csv.split("\n")[1..-1].collect do |line|
      (line.split(',').collect &:strip).join(',')
    end.join("\n")
  end


  def scheme
    all = table_data['scheme'].dup

    all.keys.each do |key|
      all.delete(key) if (key=='Ani' or key.start_with?('UM:'))
    end

    all
  end

  private
  def columns
    column_values = {}
    table_data['scheme'].each_pair do |column_name, values|
      column_values[column_name] = default_values_for_column(column_name, values)
      column_values[column_name] = value_from_query(column_name, values) if @query.include?(column_name)
    end
    column_values
  end

  def value_from_query(column_name, values)
    {:row => @query[column_name], :index => values[@query[column_name]]}
  end

  def default_values_for_column(column_name, values)
    if (not column_name.include?('Ani')) && (not column_name.start_with?('UM:'))
      values.each_pair do |key, value|
        if key.upcase.include?('TOTAL')
           return {:row => key, :index => value}
        end
      end
    end

    if column_name.include?('Judete') || column_name.include?('Localitati') || column_name.include?('Municipii si orase')
      return {:row => 'Total', :index => '112'}
    end

    if column_name.include?('Ani')
      years = values.keys.collect do |string_year|
        string_year.split('Anul ').last.to_i
      end

      return {:row => "Intre #{years.min} si #{years.max}", :index => values.values.join(',')}
    end

    if column_name.start_with?('UM:')
      return {:row => values.keys.first, :index => values[values.keys.first]}
    end

    return {:row => values.keys.first, :index => values[values.keys.first]}
  end

  def table_data
    table_data = JSON.parse(IO.read('data/ins.json'))

    table = {}
    table_data.keys.each do |key|
      table_data[key].keys.each do |second_key|
        table_data[key][second_key].keys.each do |third_key|
          table = table_data[key][second_key][third_key] if third_key == @id
        end
      end
    end
    table
  end
end