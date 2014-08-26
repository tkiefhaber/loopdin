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
        :media   => "<video autobuffer='autobuffer' controls='controls' src=#{video_source_url(work)}></video>",
      }
    }
  end

  def video_source_url(work)
    work.versions.where(approved: true).first.file.url
  end

  def format_date(date)
    [date.year, date.month, date.day].join(',')
  end


end
