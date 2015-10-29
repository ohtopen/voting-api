module HYY
  class AE::Votes < Grape::API
    desc 'Register your vote.'
    post :votes do
      # TODO: verify that @current_user is allowed to vote this id
      vote = Vote.new voter_id: @current_user.id,
                      candidate_id: params['candidate_id']

      if vote.save
        { response: 'ok' }
      else
        error!({ message: 'Vote failed', errors: vote.errors.as_json }, 422)
      end
    end
  end
end
