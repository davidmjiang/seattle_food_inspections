# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Restaurant.destroy_all
Inspection.destroy_all
Violation.destroy_all

client = SODA::Client.new({:domain=>"data.kingcounty.gov", :app_token => "6lPsMB7p130hMrUWNbgLBYQW4"})

response = client.get("gkhn-e8mn", {"$where" => "inspection_date > '2015-08-23T00:00:00.000' AND inspection_type='Routine Inspection/Field Review' AND city = 'Seattle' "})
#https://data.kingcounty.gov/resource/gkhn-e8mn.json

response.each do |r| 
  unless Restaurant.find_by(name: r.name)
    Restaurant.create(name: r.name,
                      address: r.address,
                      city: r.city.titleize,
                      zip: r.zip_code,
                      phone: r.phone
                      )
  end

  rest = Restaurant.find_by(name: r.name)
  unless Inspection.find_by(date: r.inspection_date, restaurant_id: rest.id)
    this_inspection = rest.inspections.create(date: r.inspection_date,
                          score: r.inspection_score.to_i,
                          result: r.inspection_result
    )
  end

  if r.violation_type
    this_inspection.violations.create(color: r.violation_type,
                            description: r.violation_description)
  end
  
end