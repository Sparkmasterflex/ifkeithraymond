class SubpagesController < ApplicationController
  before_filter :require_user, :only => [:index, :new, :create, :edit, :update]
  before_filter :editor_navigation, :only => [:index, :new, :edit]
  
  private

  def editor_navigation
    @webpages = Webpage.all
    @projects = Project.all
  end
end
