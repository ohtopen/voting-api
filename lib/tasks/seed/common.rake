namespace :db do

  namespace :seed do
    namespace :common do

      def create_department(code, faculty_code, name)
        Department.create! code: code,
                           name: name,
                           faculty: Faculty.find_by_code!(faculty_code)
      end

      desc 'faculties'
      task :faculties => :environment do
        puts 'Seeding faculties ...'
        Faculty.create! code: "H10", name: 'KY'
      end

      desc 'departments'
      task :departments => :environment do
        puts "Seeding departments ..."

        create_department "H10", "H10", "KY"
      end
    end

    desc 'common data (faculties, departments)'
    task :common => :environment do
      Rake::Task['db:seed:common:faculties'].invoke()
      Rake::Task['db:seed:common:departments'].invoke()
    end
  end
end
