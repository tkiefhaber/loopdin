class ProjectMailer < ActionMailer::Base
  default from: 'notifications@loopd.in'

  def new_collaboration_notification(collaborators, project)
    @collaborators = collaborators
    @project = project
    mail(
      to: @collaborators.map(&:email),
      subject: "#{@project.user.username} added you to a project"
    )
  end
end
