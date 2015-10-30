module HYY

  module AE::Entities
    class Election < Grape::Entity
      expose :id
      expose :type
      expose :name
      expose :faculty_id
      expose :department_id

      expose :alliances
      expose :candidates
    end
  end

  module AE::Entities
    class Candidate < Grape::Entity
      expose :id
      expose :alliance_id
      expose :firstname
      expose :lastname
      expose :spare_firstname
      expose :spare_lastname
      expose :name
      expose :candidate_number, :as => :number

      private
      def name
        "#{object.firstname} #{object.lastname} (#{object.spare_firstname} #{object.spare_lastname})"
      end
    end
  end

  module AE::Entities
    class Alliance < Grape::Entity
      expose :id
      expose :name
      expose :faculty_id
      expose :department_id
      expose :candidates, using: AE::Entities::Candidate
    end
  end

  class AE::Elections < Grape::API

    namespace :elections do

      route_param :election_id do

        namespace :alliances do
          desc 'Get alliances for an election'
          get do
            present Alliance.by_election(params[:election_id]),
                    with: HYY::AE::Entities::Alliance
          end
        end

        namespace :candidates do
          desc 'Get all candidates for an election'
          get do
            present Election.find(params[:election_id]).candidates,
                    with: HYY::AE::Entities::Candidate
          end

          route_param :candidate_id do
            desc 'Cast a vote for a candidate'
            post :vote do
              vote = Vote.new voter_id: @current_user.id,
                              election_id: params[:election_id],
                              candidate_id: params[:candidate_id]

              if vote.save
                { response: 'ok' }
              else
                error!(
                  {
                    message: 'Vote failed',
                    errors: vote.errors.as_json
                  }, 422)
              end
            end

          end
        end
      end

    end
  end
end
