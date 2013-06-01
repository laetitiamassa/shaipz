class ParticipationCreator
  attr_accessor :participation, :participant, :facebook_service

  def initialize(participation, facebook_service)
    @participation    = participation
    @participant      = @participation.participant
    @facebook_service = facebook_service
    @project = @participation.project
  end

  def create!
    if participation.save!
      NotificationMailer.new_participant(participant, participation.project).deliver unless participation.project.has_enough_participants?
      NotificationMailer.after_participation(participant, participation.project).deliver
      NotificationMailer.reached_minimum_participants(participant, participation.project).deliver if participation.project.has_enough_participants?
      facebook_service.post_participation_on_wall(participation) if participation.share_on_facebook
      true
    else
      false
    end
  end
end
