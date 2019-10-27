require './lib/support/imported_csv_candidate'

namespace :db do
  namespace :seed do
    namespace :edari do

      desc 'seed candidates from stdin in csv format'
      task :candidates => :environment do
        ActiveRecord::Base.transaction do
          begin

            if Candidate.count != 0
              raise "Expected Candidate table to be empty (has #{Candidate.count} candidates)."
            end

            separator = ","
            encoding = "UTF-8"
            count = 0

            Rails.logger.info "SEEDING CANDIDATES"
            puts ""
            puts "==================== CANDIDATES ======================="
            puts "Paste Candidates in CSV format, finally press ^D"
            puts "Expected format is (without header):"
            puts "name,numbering_order,short_name,candidate_count"
            puts ""

            lines = $stdin.readlines

            lines.each do |csv_row|
              count = count + 1

              CSV.parse(csv_row, col_sep: separator, encoding: encoding) do |csv_candidate|
                ImportedCsvCandidate.create_from! csv_candidate
              end
            end

            Rails.logger.info "Imported #{count} candidates from STDIN."
            Rails.logger.info "Database has now #{Candidate.count} candidates."

          end
        end

      end
    end
  end
end
