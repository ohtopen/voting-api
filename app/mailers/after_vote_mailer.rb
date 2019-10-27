class AfterVoteMailer < ApplicationMailer
  def thank(voter)
    return unless voter.email.present?

    mail(
      :to => voter.email,
      :subject => 'KY tarjoaa vaalikahvin'
    )
  end
  alias :thank_retry :thank
end
