announcements = Forem::Category.create(:name => "Meta")
Forem::Forum.create(:category => announcements, :name => "News and Announcements", :description => "Project announcements from Sponge staff.")
Forem::Forum.create(:category => announcements, :name => "Feedback", :description => "A place for the community to give feedback on the Sponge project.")

general = Forem::Category.create(:name => "General")
Forem::Forum.create(:category => general, :name => "General Discussion", :description => "Discussion about anything related to Sponge.")

plugins = Forem::Category.create(:name => "Development")
Forem::Forum.create(:category => plugins, :name => "Sponge Development", :description => "Discussion related to the development of Sponge.")
Forem::Forum.create(:category => plugins, :name => "Plugin Help", :description => "Ask for help with developing plugins here!")
Forem::Forum.create(:category => plugins, :name => "Plugin Tutorials", :description => "Post your plugin development tutorials here.")