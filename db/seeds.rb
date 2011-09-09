Locale.create(:name => "Sweden", :code => "se")
Locale.create(:name => "Norway", :code => "no")
Locale.create(:name => "Denmark", :code => "dk")
Locale.create(:name => "Finland", :code => "fi")
Locale.create(:name => "Singapore", :code => "sg")
Locale.create(:name => "England", :code => "uk")

Office.create(:name => "Stockholm", :locale => Locale.find_by_name("Sweden"), :code => "st")
Office.create(:name => "Gothenburg", :locale => Locale.find_by_name("Sweden"), :code => "gt")
Office.create(:name => "Malmoe", :locale => Locale.find_by_name("Sweden"), :code => "ma")
Office.create(:name => "Oslo", :locale => Locale.find_by_name("Norway"), :code => "os")
Office.create(:name => "Copenhagen", :locale => Locale.find_by_name("Denmark"), :code => "co")
Office.create(:name => "Helsinkki", :locale => Locale.find_by_name("Finland"), :code => "he")
Office.create(:name => "Singapore", :locale => Locale.find_by_name("Singapore"), :code => "sg")
Office.create(:name => "London", :locale => Locale.find_by_name("England"), :code => "ln")