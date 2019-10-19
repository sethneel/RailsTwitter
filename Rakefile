# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to
# Rake.

require_relative 'config/application'

Rails.application.load_tasks
# STUB

hw_num = Dir.pwd[-1]
target = "hw#{hw_num}-template"
destination = '../../templates/'

task :build do
  files = '.gitignore .rspec .rubocop.yml .travis.yml config.ru database-schema.png Gemfile Rakefile README.md app bin config db lib public spec vendor'

  FileUtils.rm_r target if Dir.exist? target
  Dir.mkdir destination unless Dir.exist? destination

  `rstub #{files} #{target}`
  Dir.chdir(target) do
    `rm app/controllers/sessions_controller.rb`
    Dir.glob('app/models/*.rb').each { |f| `rm #{f}` unless f == 'app/models/application_record.rb' }
    Dir.glob('db/migrate/*.rb').each { |f| `rm #{f}` }
    `rm -rf db/*.sqlite3`
    `rm db/schema.rb`
  end
  `cp -r #{target} #{destination}`
end

task :deploy do
  Dir.chdir("#{destination}#{target}") do
    already_committed = Dir.exist? '.git'
    `git init` unless already_committed
    `git add .`
    `git commit -m "Latest homework updates"`
    `git remote add origin https://github.com/cis196-2019s/hw#{hw_num}-template.git` unless already_committed
    `git push -u origin master`
  end
end

task :build_and_deploy do
  `rake build`
  `rake deploy`
end
# ENDSTUB
