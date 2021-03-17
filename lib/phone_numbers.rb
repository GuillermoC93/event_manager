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

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

contents.each do |row|
  phone_number = row[:homephone]
  regdate = row[:regdate]
  p regdate
  puts DateTime.strptime(regdate, "%m/%d/%y %H:%M")
end
