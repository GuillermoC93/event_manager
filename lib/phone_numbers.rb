require 'csv'
require 'time'

def clean_phone_numbers(phone_number)
  phone_number.gsub!(/\D/, '')
  if phone_number.length < 10
    'Invalid number'
  elsif phone_number.length == 10
    phone_number
  elsif phone_number.length == 11
    if phone_number[0] == '1'
      phone_number.delete_prefix!('1')
    else
      'Invalid number'
    end
  elsif phone_number.length > 11
    'Invalid number'
  end
end

def count_hours(array)
  array.max_by { |a| array.count(a) }
end

def determine_day(array)
  array.map! do |d|
    case d
    when 0 then "Sunday"
    when 1 then "Monday"
    when 2 then "Tuesday"
    when 3 then "Wednesday"
    when 4 then "Thursday"
    when 5 then "Friday"
    when 6 then "Saturday"
    end
  end
  array.max_by { |a| array.count(a) }
end

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

hours = []
days = []

contents.each do |row|
  phone_number = row[:homephone]
  regdate = row[:regdate]
  times = Time.strptime(regdate, "%m/%d/%y %H:%M")
  hours << times.hour
  days << times.wday
  # puts clean_phone_numbers(phone_number)
end

puts "The prime hours are " + count_hours(hours).to_s + "."

puts "The prime day is "

puts determine_day(days)