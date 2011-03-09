
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
      
    if company['offices'] && 
      office = company['offices'][0]
      category = CATEGORIES[company['category_code']]
      month_name = Date::MONTHNAMES[company['founded_month']]
      questions.push("This #{office['city']}, #{office['state_code']} based #{category} company was founded in #{month_name} of #{company['founded_year']}.")
    end
      
  end
end

json = JSON.parse(IO.read('/Users/mnitheib/Desktop/jellyfish.js'))
qp = QuestionParser.new()
questions = qp.parse_company(json)

questions.each do |question|
  puts "#{question}\n"
end

