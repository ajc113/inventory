namespace :db do
  desc 'reset the database by dropping the schema'
  task complete_reset: :environment do
    FileUtils.rm_f('db/schema.rb')
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke
    ActiveRecord::Tasks::DatabaseTasks.migrate
    Rake::Task['dev:prime'].invoke
  end
end
