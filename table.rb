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

  def query
    scheme = table_data['scheme']

    column_values = []
    scheme.each_pair do |column_name, values|
      if (not column_name.include?('Ani')) && (not column_name.start_with?('UM:'))
        values.each_pair do |key,value|
          if key.upcase.include?('TOTAL')
            column_values << value
            break
          end
        end
      end

      if column_name.include?('Ani')
        column_values << values.values.join(',')
      end

      if column_name.start_with?('UM:')
        column_values << values[values.keys.first]
      end
    end

    column_values.join(':')
    #'105:108:112:4399,4418,4437,4456,4475,4494,4513,4532,4551,4570,4589,4608,4627,4646,4665,4684:9685'
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

  def csv
    csv = @connection.post('/shop/excelPivot.jsp', { :matCode => id, :encQuery => query }).body
    csv.split("\n")[1..-1].join("\n")
  end

end