# Spongy [![Build Status](https://travis-ci.org/Jake0oo0/Spongy.svg?branch=master)](https://travis-ci.org/Jake0oo0/Spongy)

Spongy is a Proof of Concept website for [Sponge](http://forums.spongepowered.org/).


## Installing

* Clone the repository
* cd Spongy/
* cp config/database.yml.default config.database.yml
* Edit database settings
* cp config/initalizers/secrets.rb.default config/initializers/secrets.rb
* bundle install
* rake db:migrate
* rails server


### TODO List

* Notifications - Built in notifications, along with custom emails, and external notifications.
* Social Media - Display Social Media icons for Sponge
* Better authentication - OAuth (Github, Twitter, etc), SSO with Sponge Powered
* Moderation (Plugin approval)

### Features (Implemented)
* Plugins
  * Downloads
  * Wiki Pages
  * Stat Tracking
  * Comments
  * Categorization and Searching
* Users
  * Local Authentication
  * Profile Pages
* Downloads
  * List of Sponge builds from the CI
* Revisions
  * A list of Github revisions from various Sponge related repositories.
* Terms & Rules
* Contact Form
