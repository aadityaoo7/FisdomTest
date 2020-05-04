Given("i create booking for {string} {string} {string} {string} {string} {string} {string}")do |firstName,lastName,totalPrice,depositPaid,checkIn,checkOut,addtNeed|
  details_hash = {
    "firstname" => firstName,
    "lastname" => lastName,
    "totalprice" => totalPrice,
    "depositpaid" => depositPaid,
    "checkin" => checkIn,
    "checkout" => checkOut,
    "additionalneeds" => addtNeed
  }
  @payload = @booking_object.create_payload(details_hash)
  @response = @booking_object.create_booking(@payload)
end

And("i am verifying new booking details using booking_payload and booking_response")do
  @booking_object.verify_new_booking(@payload,@response)
end

Then("i am updating complete booking details with new details {string} {string} {string} {string} {string} {string} {string}")do |firstNameNew,lastNameNew,totalPriceNew,depositPaidNew,checkInNew,checkOutNew,addtNeedNew|
  new_details_hash = {
    "firstname" => firstNameNew,
    "lastname" => lastNameNew,
    "totalprice" => totalPriceNew,
    "depositpaid" => depositPaidNew,
    "checkin" => checkInNew,
    "checkout" => checkOutNew,
    "additionalneeds" => addtNeedNew
  }
  @new_payload = @booking_object.create_payload(new_details_hash)
  @updated_response = @booking_object.update_complete_booking(@response['bookingid'],@new_payload)
end

Then("i want to update partial booking details with new details {string} {string}")do |key,value|
  if key == "totalprice"
    value = value.to_i
  end
  @new_payload = @booking_object.create_partial_update_payload(key,value)
  @updated_response = @booking_object.update_partial_booking(@response['bookingid'],@new_payload)
end

Then("i am updating booking partially for more than one fields")do
  @updated_response = @booking_object.update_partial_booking(@response['bookingid'],@new_payload)
end

And("i am verifying updated booking details with {string} new details")do |updateType|
  @booking_object.verify_update_booking(updateType,@new_payload,@updated_response)
end
