module ApplicationHelper
  def comment_classes(comment)
    base = ['item']
    base << 'important' if comment.important
    base << 'done' if comment.addressed
    "#{base.join(' ')}"
  end
end
