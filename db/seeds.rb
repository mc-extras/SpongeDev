Forem::Category.create(:name => "General")
Forem::Forum.create(:category => Forem::Category.first, :name => "General Discussion", :description => "Discussion about anything related to Sponge.")