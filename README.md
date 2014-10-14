To install:


Copy:

```
config/initalizers/secrets.rb.default to config/initalizers/secrets.rb and fill in a Github OAuth token.
```


Copy:

```
config/database.yml.default to config/database.yml, and enter the settings for your database.
```

Run:

```
bundle install
```

Run:

```
rake db:migrate
```

Start the Rails Server:

```
rails server
```


### TODO

* Notifications, emails, desktop alerts
* Social Media
* Profiles
* Better sign in
* Moderation

### Features (Implemented)
* Plugin Page
* Sign in (Temp)
* Profile page (Temp)
* Wiki
* Comments
* Downloads page
