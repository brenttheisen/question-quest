
require 'rubygems'
require 'json'

class QuestionParser
  
  CATEGORIES = {
    'advertising' =>    'Advertising',
    'biotech' =>         'BioTech', 
    'cleantech' =>       'CleanTech', 
    'hardware' =>        'Consumer Electronics/Devices', 
    'web' =>             'Consumer Web', 
    'ecommerce' =>       'eCommerce', 
    'enterprise' =>      'Enterprise', 
    'games_video' =>     'Games, Video and Entertainment', 
    'legal' =>           'Legal', 
    'mobile' =>          'Mobile/Wireless', 
    'network_hosting' => 'Network/Hosting', 
    'consulting' =>      'Outsourcing', 
    'public_relations' =>'Public Relations', 
    'search' =>          'Search', 
    'security' =>        'Security', 
    'semiconductor' =>   'Semiconductor', 
    'software' =>        'Software', 
    'other' =>           'Other'
  }

  def parse_company company
    questions = []
      
    unless company['offices'].nil? || company['offices'].length != 1 
      office = company['offices'][0]
      category = CATEGORIES[company['category_code']]
      month_name = Date::MONTHNAMES[company['founded_month']]
      questions.push("This #{office['city']}, #{office['state_code']} based #{category} company was founded in #{month_name} of #{company['founded_year']}.")
    end
    
    unless company['acquisition'].nil? 
      acquisition = company['acquisition']
      acquiring_company = acquisition['acquiring_company']
      month_name = Date::MONTHNAMES[acquisition['acquired_month']]
      questions.push("In #{month_name} of #{acquisition['acquired_year']} this company was acquired by #{acquiring_company['name']} for a reported $#{acquisition['price_amount']}.")
    end
    
#    unless company['competitions'].nil?
#      founders = 
#      
#      questions.push("Founded in #{company['founded_year']} by #{founders_grammar} this company counts #{competitors_grammar} as competition.")
#    end

  end
  
  def list_grammar(list, last_join='and')
    
  end
end

json = JSON.parse(IO.read(ARGV[0]))
qp = QuestionParser.new()
questions = qp.parse_company(json)

questions.each do |question|
  puts "#{question}\n"
end

