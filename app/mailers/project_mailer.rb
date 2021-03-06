class ProjectMailer < ActionMailer::Base
  default from: 'notifications@loopd.in'

  def new_collaboration_notification(collaborators, project)
    @collaborators = collaborators
    @project = project
    attachments.inline['loopdin-logo.png'] = File.read("#{Rails.root}/app/assets/images/bigchicken.png")
    mail(
      to: @collaborators.map(&:email),
      subject: "#{@project.user.username} added you to a project"
    )
  end

  def version_submitted_notification(collaborators, project)
    @collaborators = collaborators
    @project = project
    attachments.inline['loopdin-logo.png'] = File.read("#{Rails.root}/app/assets/images/bigchicken.png")
    mail(
      to: @collaborators.map(&:email),
      subject: "#{@project.user.username} added a new version to #{@project.title}"
    )
  end

  def version_needs_work_notification(collaborators, project)
    @collaborators = collaborators
    @project = project
    attachments.inline['loopdin-logo.png'] = File.read("#{Rails.root}/app/assets/images/bigchicken.png")
    mail(
      to: @collaborators.map(&:email),
      subject: "couple things for you about #{@project.title}"
    )
  end

  def version_approved_notification(collaborators, project)
    @collaborators = collaborators
    @project = project
    attachments.inline['loopdin-logo.png'] = File.read("#{Rails.root}/app/assets/images/bigchicken.png")
    mail(
      to: @collaborators.map(&:email),
      subject: "#{@project.title} was approved!"
    )
  end
end
