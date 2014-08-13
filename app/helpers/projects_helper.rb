module ProjectsHelper
  def can_comment_on_project?(project)
    project.collabos.map(&:id).include?(current_user.id)
  end

  def can_update_comments?(project)
    project.user_id == current_user.id || project.collabos.map(&:id).include?(current_user.id)
  end

  def can_approve?(project)
    project.collabos.map(&:id).include?(current_user.id)
  end
end
