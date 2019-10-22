require 'json'

namespace :data do

  task :sync_events => :environment do
      
    tinkuy_events_endpoint = "https://tinkuy.dk/events.json"
    # payload = { email: params['login']['email'], password: params['login']['password'] }
    # headers = { :Authorization => "Token #{NCM_API_TOKEN}" }

    response = RestClient.get(tinkuy_events_endpoint)
    body = JSON.parse(response.body)
    for e in body
      input = {
        name: e['name'],
        data:  {
          duration: e['duration'],
          description: e['description']

        }
        date: e['startdate']
        time: e['starttime']
      }
      puts e
      {"id"=>11580, "confirmed"=>true, "user_id"=>1136, "url"=>"https://www.tinkuy.dk/events/11580.json"}
    end

  end

end
