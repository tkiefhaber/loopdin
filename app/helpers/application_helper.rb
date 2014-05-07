module ApplicationHelper
  def comment_classes(comment)
    base = ['item']
    base << 'important' if comment.priority < 3
    base << 'done' if comment.addressed
    "#{base.join(' ')}"
  end
end
