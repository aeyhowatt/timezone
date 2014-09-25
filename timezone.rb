#Thanatseth Howattanapan 5631254121

require 'sinatra'
require 'timezone'

get '/'  do
	erb :layout	
end

post '/city' do
	input = params[:input]
	world_timezone = Timezone::Zone.names
	input_caps = input.split.map(&:capitalize).join(' ')
	
	begin
	if (input.include?" ")
		full_text = input_caps.split(' ')
		word1 = full_text[0]
		word2 = full_text[1]
		city = world_timezone.find{ |e| /#{word1}_#{word2}/ =~ e}
	else  
		city = world_timezone.find{ |e| /#{input_caps}/ =~ e}
	end
	
	timezone = Timezone::Zone.new :zone => city
	get_time = timezone.time Time.now
	time = get_time.to_s.split(' ')
	current_time = time[1]
	hrs = current_time[0,2].to_i
	am_hrs = current_time[0,2]
	mins = current_time[2..4]

	if hrs>12&&hrs<=23
		pm = (hrs-12).to_s + mins
		"The current time in #{input_caps} is
		 #{pm} PM"
	else 
		 am = am_hrs + mins
	 	"The current time in #{input_caps} is  
	 	#{am} AM"
	end
	rescue
		"Sorry! We cannot find the time at #{input_caps}."
	end


end

