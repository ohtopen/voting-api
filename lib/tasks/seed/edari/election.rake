
namespace :db do
  namespace :seed do
    namespace :edari do

      desc 'seed election'
      task :election => :environment do
        e = Election.create! name: "Elections #{Time.now.year}"
        Rails.logger.info "Created election: #{e.name}"
      end

    end
  end
end
