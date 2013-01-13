class ParticipationCreator
  attr_accessor :participation, :participant, :facebook_service

  def initialize(participation, facebook_service)
    @participation    = participation
    @participant      = @participation.participant
    @facebook_service = facebook_service
  end

  def create!
    if participation.save!
      NotificationMailer.new_participant(participant, participation.project).deliver
      NotificationMailer.after_participation(participant,participation.project).deliver
      facebook_service.post_participation_on_wall(participation) if participation.share_on_facebook
      true
    else
      false
    end
  end
end
