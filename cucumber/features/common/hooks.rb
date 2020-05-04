#created on 03-05-2020 by aaditya mahajan

#here generating auth token for DELETE and PUT request
Before("@test")do
  $env = YAML.load_file("features/common/baseURL_endpoint.yaml")
   auth_body = {
                   "username" => "admin",
                   "password" => "password123"
               }
   auth_token_response = HTTParty.post($env['Fisdom']['base_url'].to_s + $env['Fisdom']['auth'].to_s, 
                        :headers => {'Content-Type' => 'application/json'}, :body=> auth_body.to_json)    
   if auth_token_response.code == 200 && auth_token_response != nil && auth_token_response.has_key?('token')
    $auth_token = "token=#{auth_token_response['token']}"
   else auth_token_response.has_key?('reason')
    abort "ABORTED! auth token not generated, response is #{auth_token_response['reason']}"
   end
end

#here creating object of the class
Before("@booking")do
 @booking_object = Booking::GuestBooking.new
end

#here doing report generation
at_exit do 
  dirname = File.dirname('./output/result')
  unless File.directory?(dirname)
   FileUtils.mkdir_p(dirname)
  end
ReportBuilder.configure do |config|
  config.color = 'indigo'
  config.json_path = './json_report' 
  config.html_report_path = "./output/#{Time.now.to_s.tr('-','').tr(':','').tr(' ','').tr('+','')}"
  config.report_types = [:html]
  config.report_title = 'Fisdom: Test Report'
  end
ReportBuilder.build_report
end