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

  def version_submitted_notification(collaborators, project)
    @collaborators = collaborators
    @project = project
    mail(
      to: @collaborators.map(&:email),
      subject: "#{@project.user.username} added a new version to #{@project.title}"
    )
  end

  def version_needs_work_notification(collaborators, project)
    @collaborators = collaborators
    @project = project
    mail(
      to: @collaborators.map(&:email),
      subject: "couple things for you about #{@project.title}"
    )
  end

  def version_approved_notification(collaborators, project)
    @collaborators = collaborators
    @project = project
    mail(
      to: @collaborators.map(&:email),
      subject: "#{@project.title} has been approved!"
    )
  end
end
