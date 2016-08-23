desc "Calling the API"
task :call_api => :environment do
  puts "calling the API"
  client = SODA::Client.new({:domain=>"data.kingcounty.gov", :app_token => "6lPsMB7p130hMrUWNbgLBYQW4"})
  search_date = 1.day.ago
  response = client.get("gkhn-e8mn", {"$where" => "inspection_date > '#{search_date}' AND inspection_type='Routine Inspection/Field Review' AND city = 'Seattle' "})
  response.each do |r|
    unless Restaurant.find_by(name: r.name)
    Restaurant.create(name: r.name,
                      address: r.address,
                      city: r.city.titleize,
                      zip: r.zip_code,
                      phone: r.phone
                      )
    puts "Added a new restaurant"
    end

    rest = Restaurant.find_by(name: r.name)
    unless Inspection.find_by(date: r.inspection_date, restaurant_id: rest.id)
      this_inspection = rest.inspections.create(date: r.inspection_date,
                            score: r.inspection_score.to_i,
                            result: r.inspection_result
      )
      puts "Added a new inspection"
    end

    if r.violation_type
      this_inspection.violations.create(color: r.violation_type, description: r.violation_description)
      puts "Added a violation"
    end
  end
  puts "Done"
end