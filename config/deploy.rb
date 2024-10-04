# config valid for current version and patch releases of Capistrano
lock "~> 3.19.1"

set :application, "qna"
set :repo_url, "git@github.com:fedor-ches098/rails_advanced.git"

set :branch, "main"

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/qna/qna"
set :deploy_user, 'qna'

# Default value for :pty is false
set :pty, false

# Default value for :linked_files is []
append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "storage"

after 'deploy:publishing', 'unicorn:restart'
