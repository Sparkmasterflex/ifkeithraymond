module AppSystem
  NAME = Rails.application.class.to_s.split("::").first
  
  class Templates
    HOME           = 10
    INFORMATIONAL  = 20
    SALES          = 30
    CONTACT        = 40

    LABELS = {HOME => 'Home', INFORMATIONAL => 'Informational', SALES => 'Sales', CONTACT => 'Contact'}
    PATHS = {HOME => 'templates/home', INFORMATIONAL => '/templates/informational', SALES => '/templates/sales', CONTACT => '/templates/contact'}

    def self.options_for_select
      LABELS.sort.unshift([nil, "Please Select"]).collect { |arr| arr.reverse }
    end
  end
end
