set :stages,        %w(staging production)
set :default_stage, :staging

require 'capistrano/ext/multistage'
begin
  require 'capistrano_colors'
rescue LoadError
end

set :application,   'cap-demo'
set :deploy_to,     "/var/www/apps/#{application}"

set :use_sudo,      false

set :repository,    'git://github.com/jasonlai/cap-demo.git'
set :branch,        'master'

set :scm,           :git

role :web,  'localhost'                         # Your HTTP server, Apache/etc
role :app,  'localhost'                         # This may be the same as your `Web` server
role :db,   'localhost', :primary => true       # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end