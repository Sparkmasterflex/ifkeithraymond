namespace :sass do
  desc 'Begin SASS watching main.scss and write changes to its cooresponding css file.'
  task :base => :environment do
    puts "Watching base.scss."
    sh "sass --watch #{RAILS_ROOT}/public/stylesheets/base.scss:#{RAILS_ROOT}/public/stylesheets/base.css"
  end

  desc 'Begin SASS watching editor.scss and write changes to its cooresponding css file.'
  task :editor => :environment do
    puts "Watching editor.scss."
    sh "sass --watch #{RAILS_ROOT}/public/stylesheets/editor.scss:#{RAILS_ROOT}/public/stylesheets/editor.css"
  end

  desc 'Begin SASS watching gallery.scss and write changes to its cooresponding css file.'
  task :gallery => :environment do
    puts "Watching gallery.scss."
    sh "sass --watch #{RAILS_ROOT}/public/stylesheets/gallery.scss:#{RAILS_ROOT}/public/stylesheets/gallery.css"
  end
end
