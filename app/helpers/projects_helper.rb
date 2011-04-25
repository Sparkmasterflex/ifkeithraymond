module ProjectsHelper
  def end_date(date)
    str = date > Time.now ? "Estimated end date: " : "End date: "
    str += date.strftime("%m/%d/%Y");
  end
end
