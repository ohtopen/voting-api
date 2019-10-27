require './lib/support/imported_csv_candidate'

namespace :db do
  namespace :seed do
    namespace :edari do
      namespace :demo do

        desc 'demo candidates from 2019 elections (requires alliances)'
        task :candidates => :environment do
          Rails.logger.info "Seeding candidates ..."

          filename = "./lib/support/data/2019_candidates.csv"

          Rails.logger.info "BEGIN: Database has now #{Candidate.count} candidates."

          separator = ","
          encoding = "UTF-8"
          count = 0

          CSV.foreach(filename,
                        col_sep: separator,
                        encoding: encoding,
                        headers: true) do |csv_candidate|

            count = count + 1
            ImportedCsvCandidate.create_from! csv_candidate
          end

          Rails.logger.info "Imported #{count} candidates"
          Rails.logger.info "END: Database has now #{Candidate.count} candidates."
        end

      end
    end
  end
end