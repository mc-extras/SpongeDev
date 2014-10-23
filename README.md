# Spongy [![Build Status](https://travis-ci.org/Jake0oo0/Spongy.svg?branch=master)](https://travis-ci.org/Jake0oo0/Spongy)

Spongy is a Proof of Concept website for [Sponge](http://forums.spongepowered.org/).


## Installing

```bash
git clone https://github.com/Jake0oo0/Spongy.git && cd Spongy/
cp config/database.yml.default config/database.yml
cp config/initalizers/secrets.rb.default config/initializers/secrets.rb
bundle install
rake db:migrate
rails s
```

## Side projects
| Name | Description |
| ---- | ----------- |
| [Crafatar](https://github.com/Jake0oo0/crafatar) | An avatar service for Minecraft |
| [Sponge Auth Server](https://github.com/Jake0oo0/sponge_auth_server) | A Minecraft server implementation that validates MC accounts for the website |
| [MC Auth](https://github.com/Jake0oo0/minecraft_auth) | Ruby gem for authenticating Minecraft accounts |
| [Sponge me!](https://github.com/Jake0oo0/sponge-me) | Python application for managing Sponge plugins |


## TODO

* [ ] Notifications - Built in notifications, along with custom emails, and external notifications.
* [ ] Social Media - Display Social Media icons for Sponge
* [ ] Better authentication - OAuth (Github, Twitter, etc), SSO with Sponge Powered
* [ ] Moderation (Plugin approval)
* [x] Plugins
  * [x] Downloads
  * [x] Wiki Pages
  * [x] Stat Tracking
  * [x] Comments
  * [x] Categorization and Searching
* [x] Users
  * [x] Local Authentication
  * [x] Profile Pages
* [x] Downloads
  * [x] List of Sponge builds from the CI
* [x] Revisions
  * [x] A list of Github revisions from various Sponge related repositories.
* [x] Terms & Rules
* [x] Contact Form
