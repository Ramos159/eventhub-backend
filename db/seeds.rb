# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'rest-client'
require 'pry'

api_links=["https://app.ticketmaster.com/discovery/v2/events.json?size=200&classificationName=sports&countryCode=US&apikey=#{Rails.application.credentials.api}",
"https://app.ticketmaster.com/discovery/v2/events.json?size=200&classificationName=music&countryCode=US&apikey=#{Rails.application.credentials.api}",
"https://app.ticketmaster.com/discovery/v2/events.json?size=200&classificationName=Arts&Theatre&countryCode=US&apikey=#{Rails.application.credentials.api}",
"https://app.ticketmaster.com/discovery/v2/events.json?size=200&classificationName=miscellaneous&countryCode=US&apikey=#{Rails.application.credentials.api}"]

suggest_link = "https://app.ticketmaster.com/discovery/v2/suggest.json?apikey=#{Rails.application.credentials.api}"

venue_checker = {}
event_checker = {}
#just something to put on term, ticketmaster api limit at 200 for discovery
counter=0
# you can def put this two objects into one, come back to it later

def check_for_sale(new_event,event_data)
  if event_data["dates"]["status"]["code"] == "onsale"
    new_event.on_sale = true
  else
    new_event.on_sale = false
  end
end

def set_event_images(new_event,event_data)
  event_data["images"].each do |image|
      new_event.images.push(image["url"])
  end
end

def set_venue_images(new_venue,images)
  if images === nil
    new_venue.images = nil
  elsif images.length > 1
    images.each do |image|
    new_venue.images.push(image["url"])
    end
  else
    new_venue.images.push(images[0]["url"])
  end
end

def set_event_info(new_event,event_data)
  new_event["event_info"]["date"] = event_data["dates"]["start"]["localDate"].to_date
  new_event["event_info"]["time"]= event_data["dates"]["start"]["localTime"]
  new_event["event_info"]["timezone"]= event_data["dates"]["timezone"]
end

def set_sale_info(new_event,event_data)
  new_event["sale_info"]["start_time"] = event_data["sales"]["public"]["startDateTime"]
  new_event["sale_info"]["start_time"] = event_data["sales"]["public"]["endDateTime"]
end

def set_categories(new_event,event_data)
  if event_data["classifications"][0]["genre"]
    new_event.classifications["genre"]=event_data["classifications"][0]["genre"]["name"]
  else new_event.classifications["genre"]= nil
  end

  if event_data["classifications"][0]["subGenre"]
   new_event.classifications["sub_genre"]=event_data["classifications"][0]["subGenre"]["name"]
  else
    new_event.classifications["sub_genre"]=nil
  end

  if event_data["classifications"][0]["segment"]
    new_event.classifications["main_category"]= event_data["classifications"][0]["segment"]["name"]
  else
    new_event.classifications["main_category"] = nil
  end

  if event_data["classifications"][0]["genre"]
    new_event.classifications["sub_category"]= event_data["classifications"][0]["genre"]["name"]
  else
    new_event.classifications["sub_category"]=nil
  end

  end

def set_pricing_info(event,event_data)
  if event_data["priceRanges"]

    event["pricing_info"]["min"] = event_data["priceRanges"][0]["min"]
    event["pricing_info"]["max"] = event_data["priceRanges"][0]["max"]
    event["pricing_info"]["currency"] = event_data["priceRanges"][0]["currency"]
  else

    event["pricing_info"] = nil

end

end


def create_venue_event(event_data,event,venue)
  ve = VenueEvent.new
  set_pricing_info(ve,event_data)
  set_event_info(ve,event_data)
  set_sale_info(ve,event_data)
  check_for_sale(ve,event_data)
  if event.id
    ve.event_id = event.id
  else
    puts"ERROR IN EVENT"
    binding.pry
  end
  if venue.id
    ve.venue_id = venue.id
  else
    puts"ERROR IN VENUE"
    binding.pry
  end
  ve.save
  ve
end

def set_boxoffice_info(venue,venue_data)

  if venue_data["boxOfficeInfo"]

    if venue_data["boxOfficeInfo"]["phoneNumberDetail"]
      venue["box_office_info"]["phone_details"]= venue_data["boxOfficeInfo"]["phoneNumberDetail"]
    else
      venue["box_office_info"]["phone_details"]= nil
    end

    if venue_data["boxOfficeInfo"]["acceptedPaymentDetail"]
      venue["box_office_info"]["accepted_payments"]= venue_data["boxOfficeInfo"]["acceptedPaymentDetail"]
    else
      venue["box_office_info"]["accepted_payments"]= nil
    end

    if venue_data["boxOfficeInfo"]["openHoursDetail"]
      venue["box_office_info"]["open_hours"]= venue_data["boxOfficeInfo"]["openHoursDetail"]
    else
      venue["box_office_info"]["open_hours"]= nil
    end

    if venue_data["boxOfficeInfo"]["willCallDetail"]
      venue["box_office_info"]["will_call_details"]= venue_data["boxOfficeInfo"]["willCallDetail"]
    else
     venue["box_office_info"]["will_call_details"]= nil
    end

  else
    venue["box_office_info"]["phone_details"]= nil
    venue["box_office_info"]["accepted_payments"]= nil
    venue["box_office_info"]["open_hours"]= nil
    venue["box_office_info"]["will_call_details"]= nil
  end


end


def set_address_info(venue,venue_data)
  if venue_data["address"].keys.length > 1
  venue["address_info"]["address"] = venue_data["address"]["line1"].concat(venue_data["address"]["line2"])
  else
    venue["address_info"]["address"] = venue_data["address"]["line1"]
  end

  if venue_data["location"]
    venue["address_info"]["latitude"]= venue_data["location"]["latitude"]
    venue["address_info"]["longitude"]= venue_data["location"]["longitude"]
  else
    venue["address_info"]["location"]=nil
  end
  venue["address_info"]["zip_code"] = venue_data["postalCode"]
  venue["address_info"]["city"] = venue_data["city"]["name"]
  venue["address_info"]["state"] = venue_data["state"]["name"]
  venue["address_info"]["country"] = venue_data["country"]["name"]
end


def set_venue_info(venue,venue_data)
  set_address_info(venue,venue_data)
  set_boxoffice_info(venue,venue_data)
end

def create_venue(venue_data)
  new_venue = Venue.new
  new_venue.name = venue_data["name"]
  # if venue_data["address"].keys.length > 1
  # new_venue.address = venue_data["address"]["line1"].concat(venue_data["address"]["line2"])
  # else
  #   new_venue.address = venue_data["address"]["line1"]
  # end
  set_venue_info(new_venue,venue_data)
  set_venue_images(new_venue,venue_data["images"])

  new_venue.save
  new_venue
end

def check_event(event_data,checker)
  if checker[event_data["name"]]
    Event.find_by(name:event_data["name"])
  else
    checker[event_data["name"]]=true
    event = create_event(event_data)
  end
end

def check_venue(event_data,checker)
  if checker[event_data["_embedded"]["venues"][0]["name"]]
    Venue.find_by(name:event_data["_embedded"]["venues"][0]["name"])
  else
    checker[event_data["_embedded"]["venues"][0]["name"]] = true
    venue = create_venue(event_data["_embedded"]["venues"][0])
  end
end

 def create_event(event)
   new_event = Event.new
   new_event.name = event["name"]
   # check_for_sale(new_event,event)
   set_categories(new_event,event)
   set_event_images(new_event,event)
   new_event.save
   new_event
 end



def go_through_events(events,venue_checker,event_checker,counter)
  events.each do |event|
    new_event = check_event(event,event_checker)
    new_venue = check_venue(event,venue_checker)
    new_venue_event = create_venue_event(event,new_event,new_venue)
    if new_venue.id != nil
      # puts new_event.classifications["main_category"]
      counter = counter +1
      puts(counter)
    else
      binding.pry
    end
  end
end

  def run_database(links,venue_checker,event_checker,counter)
    links.each do |link|
      response = RestClient.get(link)
      response_JSON = JSON.parse(response)
      events =  response_JSON["_embedded"]["events"]
      go_through_events(events,venue_checker,event_checker,counter)
    end
  end

  def check_suggested_event(event)
    checked_event = Event.find_by(name:event["name"])
    if checked_event === nil
    else
      checked_event.update(suggested:true)
      puts"#{checked_event.name}"
    end
  end

  def check_suggested_venue(venue)
    checked_venue = Venue.find_by(name:venue["name"])
    if checked_venue === nil
    else
      checked_venue.update(suggested:true)
      puts"#{checked_venue.name}"
    end
  end


  def run_suggested(link)
      resp = RestClient.get(link)
      resp_json = JSON.parse(resp)
      good_stuff = resp_json["_embedded"]
      events = good_stuff["events"]
      venues = good_stuff["venues"]

      events.each do |event|
        check_suggested_event(event)
      end

      venues.each do |venue|
        check_suggested_venue(venue)
      end
  end

  run_database(api_links,venue_checker,event_checker,counter)
  user = User.create(username:"edwin",password:"ed",email:"edwinramos269@gmail.com",avatar:"https://png.pngtree.com/svg/20170308/508749a69e.svg")
  ticket = Ticket.create(user_id:1,venue_event_id:1,bought:true)
  Ticket.create(user_id:1,venue_event_id:2,bought:true)
    Ticket.create(user_id:1,venue_event_id:3,bought:true)
    Ticket.create(user_id:1,venue_event_id:5,bought:false)
  venue_event = VenueEvent.find(1)
  review = Review.create(user_id:1,venue_event_id:1,rating:10,body:"THIS IS GREAT WOOOOOO")

  run_suggested(suggest_link)
