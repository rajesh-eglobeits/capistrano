#############################################################
# Application
#############################################################

set :application, "capistrano-test"
set :deploy_to, "/home3/eglobeit/public_html/domains/capistrano"

#############################################################
# Settings
#############################################################

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :use_sudo, false
set :scm_verbose, true
set :rails_env, "production"

#set :app_symlinks, ["/public/media", "/public/var"]
#set :app_shared_dirs, ["/public/app/etc", "/public/media", "/public/var"]
#set :app_shared_files, ["/public/app/etc/local.xml", "/public/.htaccess", "/public/.htpasswd", "/public/robots.txt"]
#############################################################
# Servers
#############################################################

set :user, "eglobeit"
set :domain, "eglobeits.com"
server domain, :app, :web
role :db, domain, :primary => true

#############################################################
# Git
#############################################################

set :scm, :git
set :branch, "master"
set :scm_user, 'eglobeit'
set :repository, "git@github.com:rajesh-eglobeits/capistrano.git"
set :deploy_via, :remote_cache

set :keep_releases, 2

############################################################
# Change File permissions
desc "Pragmatically accept that this needs to be done and set the file permissions for Staging"
task :file_perms_stage do
  #run "chmod 755 -R #{latest_release}"
  #run "chmod 755 -R #{latest_release}/public/index.php"
end

after 'deploy:finalize_update', 'file_perms_stage'
after "deploy:update", "deploy:cleanup"