class ProjectsController < ApplicationController
  before_filter :get_project, :only => [:show, :edit, :update]
  before_filter :require_user, :only => [:index, :new, :create, :edit, :update]
  before_filter :editor_navigation, :only => [:index, :new, :edit, :update, :create]
  before_filter :editor_layout, :only => [:edit]

  def index
    @projects_page = Project.paginate(:all, :page => params[:page], :per_page => 15, :order => :created_at)
    render :layout => 'editor'
  end

  def all_projects
    options = {:page => params[:page], :per_page => 15, :order => :created_at}
    options.merge!(:conditions => {:end_date => Project.get_range(params[:month])}) unless params[:month].nil?
    options.merge!(:conditions => ['id IN (?)', Project.with_technology(params[:technology])]) unless params[:technology].nil?
    @projects = Project.paginate(:all, options)
  end

  def show
    @images = @project.images.enabled_images
  end

  def new    
    @project = Project.new
    @project.features.build
    @features = @project.features
    render :layout => 'editor'
  end

  def create
    @project = Project.new(params[:project])

    if @project.save
      redirect_to projects_path
    else
      render :layout => 'editor', :action => 'new'
    end
  end

  def edit
  end

  def update
    if @project.update_attributes(params[:project])
      redirect_to projects_path
    else
      render :layout => 'editor', :action => 'edit'
    end
  end

  private

  def get_project
    @project = Project.find(params[:id])
  end
end
