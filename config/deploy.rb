require "bundler/capistrano"
set :application, "Sponge"

set :scm, :git
set :repository, "git@github.com:Jake0oo0/Sponge-Site.git"
set :branch, "master"
set :deploy_via, :remote_cache
set :deploy_to, "/home/deployer/Sponge"
set :user, "deployer"
set :use_sudo, false
set :rails_env, :production

ssh_options[:forward_agent] = true
default_run_options[:shell] = '/bin/bash --login'

server "sponge.jake0oo0.me", :app, :web, :db, :primary => true

namespace :passenger do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after :deploy, "passenger:restart"