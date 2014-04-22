require 'json'

class Table

  attr_reader :id
  def initialize(id)
    @id = id
    @connection = Faraday.new(:url => 'http://statistici.insse.ro')
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
    csv = @connection.post('/shop/excelPivot.jsp', { :matCode => id, :encQuery => query }).body
    csv.split("\n")[1..-1].collect do |line|
      (line.split(',').collect &:strip).join(',')
    end.join("\n")

  end

  private
  def columns
    scheme = table_data['scheme']

    column_values = {}
    scheme.each_pair do |column_name, values|
      if (not column_name.include?('Ani')) && (not column_name.start_with?('UM:'))
        values.each_pair do |key, value|
          if key.upcase.include?('TOTAL')
            column_values[column_name] = { :row => key, :index => value}
            break
          end
        end
      end

      if column_name.include?('Judete') || column_name.include?('Localitati') || column_name.include?('Municipii si orase')
        column_values[column_name] = { :row => 'Total', :index => '112'}
      end

      if column_name.include?('Ani')
        years = values.keys.collect do |string_year|
          string_year.split('Anul ').last.to_i
        end

        column_values[column_name] = { :row => "Intre #{years.min} si #{years.max}", :index => values.values.join(',')}
      end

      if column_name.start_with?('UM:')
        column_values[column_name] = { :row => values.keys.first, :index => values[values.keys.first]}
      end
    end
    column_values
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