set :application,       'filepile'
set :user, 							'filepile'
set :use_sudo, 			    false
set :scm,               'git'
set :repository,        'git://github.com/yves-vogl/filepile.git'
set :branch,            'master'
set :deploy_to,         '/opt/filepile'

role :app, 'staging.lan'
role :web, 'staging.lan'
role :db,  'staging.lan', :primary => true

task :after_setup do
  run "mkdir -m 0755 #{shared_path}/upload"
  run "chmod -R 0755 #{deploy_to}"
end

task :after_update_code, :roles => :app do
  # Upload database.yml - it is not included in the repository for security reasons
	put File.read("config/database.production.yml"), "#{release_path}/config/database.yml", :mode => 0444
	
  # Share uploaded documents between iterations
  run "rm -R #{release_path}/upload && ln -nfs #{shared_path}/upload #{release_path}/upload"
  
  # Build C-extensions
  run "rake gems:build -f #{release_path}/Rakefile"
end

namespace :deploy do
  desc 'Start Application'
  task :start, :roles => :app do
    puts 'Please start Apache manually.'
  end
  
  desc 'Stop Application'
  task :stop, :roles => :app do
    puts 'Please stop Apache manually.'
  end
  
  desc 'Restart Application'
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end