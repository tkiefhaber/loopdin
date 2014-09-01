class Timeline
  def initialize(user, works)
    @user  = user
    @works = works
  end

  def format
    {
      :timeline => {
        :headline => @user.username,
        :type     => 'default',
      }.merge!(dates)
    }
  end

  private

  def dates
    {
      :date => @works.map{|work| date(work)}
    }
  end

  def date(work)
    {
      :startDate => format_date(work.versions.last.created_at),
      :endDate   => format_date(work.approved_at),
      :headline  => work.title,
      :text      => "<p>#{work.description}</p>",
      :asset     => {
        :media   => media_html(work),
      }
    }
  end

  def media_html
    if work.versions.where(approved:true).first.file_content_type == 'image/png'
      "<image  src=#{source_url(work)}></image>"
    else
      "<video autobuffer='autobuffer' controls='controls' src=#{source_url(work)}></video>"
    end
  end

  def source_url(work)
    work.versions.where(approved: true).first.file.url
  end

  def format_date(date)
    [date.year, date.month, date.day].join(',')
  end


end
