#created on 03-05-2020 by aaditya mahajan
module Booking
  class GuestBooking

    def initialize
      @partial_update_payload
    end

    def create_payload(guest_details_hash)
      guest_details = {
        "firstname" => guest_details_hash['firstname'],
        "lastname" => guest_details_hash['lastname'],
        "totalprice" => guest_details_hash['totalprice'].to_i,
        "depositpaid" => guest_details_hash['depositpaid'].eql?('true')?true:false,
        "bookingdates" => {
          "checkin" => guest_details_hash['checkin'],
        "checkout" => guest_details_hash['checkout']},
        "additionalneeds" => guest_details_hash['additionalneeds']
      }
      return guest_details
    end

    def create_partial_update_payload(key,value)
      date_hash = { "bookingdates" => {} }
      if key == "depositpaid"
        value = value.eql?('true')?true:false
      end
      update_payload = {
        key => value
      }
      if @partial_update_payload == nil
        if key == "checkin" ||  key == "checkout"
          date_hash['bookingdates'].merge!(update_payload)
          update_payload = date_hash
          @partial_update_payload = update_payload
        else
          @partial_update_payload = update_payload
        end
      else
        if key == "checkin" || key == "checkout"
          date_hash['bookingdates'].merge!(update_payload)
          update_payload = date_hash
          @partial_update_payload = update_payload
          @partial_update_payload.merge!(update_payload)
        else
          @partial_update_payload.merge!(update_payload)
        end
      end
    end

    def create_booking(guest_details)
      booking_response = HTTParty.post($env['Fisdom']['base_url'].to_s + $env['Fisdom']['booking']['do_booking'].to_s,:headers => {'Content-Type' => 'application/json'}, :body => guest_details.to_json)
      if booking_response.code == 200 && booking_response.has_key?('bookingid') && booking_response['bookingid'] != nil && booking_response['bookingid'].class == Integer
        return booking_response
      else
        abort ("Error occured during booking creation, Error is #{booking_response}")
      end
    end

    def update_partial_booking(booking_id,update_payload)
      booking_response = HTTParty.patch($env['Fisdom']['base_url'].to_s + $env['Fisdom']['booking']['crud_booking'].gsub(':booking_id',booking_id.to_s),
                                        :headers => {'Content-Type' => 'application/json','Cookie' => $auth_token}, :body=> update_payload.to_json)
      if booking_response.code == 200
        return booking_response
      else
        abort ("Error occured during booking partial updation, Error is #{booking_response}")
      end
    end

    def update_complete_booking(booking_id,update_payload)
      booking_response = HTTParty.put($env['Fisdom']['base_url'].to_s + $env['Fisdom']['booking']['crud_booking'].gsub(':booking_id',booking_id.to_s),
                                      :headers => {'Content-Type' => 'application/json','Cookie' => $auth_token}, :body=> update_payload.to_json)
      if booking_response.code == 200
        return booking_response
      else
        abort ("Error occured during booking partial updation, Error is #{booking_response}")
      end
    end


    def verify_new_booking(booking_payload,booking_response)
      if (booking_payload == booking_response['booking']) == true
        puts "Booking created as per details given"
        puts booking_response
      else
        puts "Booking not created as per details given, response is #{booking_response}"
      end
    end

    def verify_update_booking(update_type,update_payload,updated_booking)
      case update_type
      when 'partial'
        if update_payload.has_key?('bookingdates') == true
          if (update_payload['bookingdates']<updated_booking['bookingdates']) == true
          else
            abort ("ABORTED! Booking details not uppdated. response is #{updated_booking}")
          end
        else
          if (update_payload<updated_booking) == true
            puts "partial booking details updated with new details, new details are #{updated_booking.to_hash}"
          else
            abort "ABORTED! Booking details not updated, response is #{updated_booking}"
          end
        end
      when 'complete'
        if (update_payload == updated_booking.to_hash) == true
          puts "Complete booking details updated with new details, new details are #{updated_booking}"
        else
          abort "ABORTED! Error occured during complete booking updation, Error is #{updated_booking}"
        end
      end
    end
  end
end
