class WebpagesController < ApplicationController
  before_filter :require_user, :only => [:dashboard, :index, :new, :create, :edit, :update]
  before_filter :editor_navigation, :only => [:dashboard, :index, :new, :edit]
  before_filter :editor_layout, :only => [:dashboard, :index]

  def dashboard
    
  end

  def index

  end

  def new
    @webpage = Webpage.new
    render :layout => 'editor'
  end

  def create
    @webpage = Webpage.new(params[:webpage])

    if @webpage.save
      redirect_to webpages_path
    else
      render :action => 'new'
    end
  end

  def show
    page = params[:page_alias] ? params[:page_alias] : 'home'
    @webpage = Webpage.find(:first, :conditions => {:page_alias => page})
    @subpages = @webpage.subpages.paginate(:page => params[:page], :per_page => 4)
    @latest_blog = Blog.latest
    @projects = Project.find(:all, :conditions => {:front_page => 1}) if page == 'home'
    @contact = Contact.new if page == 'contact'
  end

  def edit
    @webpage = Webpage.find(params[:id])
    @subpages = @webpage.subpages.build
    @images = @webpage.images.build
    render :layout => 'editor'
  end

  def update
    @webpage = Webpage.find(params[:id])
    @webpage.images.build(params[:images]) if params[:images]

    if @webpage.update_attributes(params[:webpage])
      redirect_to webpages_path
    else
      render :action => :edit
    end
  end
end