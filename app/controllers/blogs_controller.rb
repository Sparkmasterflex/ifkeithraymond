class BlogsController < ApplicationController
  before_filter :get_blog, :only => [:show, :edit, :update]
  before_filter :require_user, :only => [:index, :new, :create, :edit, :update]
  before_filter :editor_navigation, :only => [:index, :new, :edit]

  def index
    options = {:page => params[:page], :per_page => 15, :order => 'updated_at DESC'}
    options.merge!(:conditions => {:created_at => Blog.get_range(params[:month])}) unless params[:month].nil?
    @blogs = Blog.paginate(:all, options)
    @months = Blog.seperate_by_months

    render :layout => 'editor'
  end

  def all_blogs
    options = {:page => params[:page], :per_page => 15, :order => 'updated_at DESC'}
    options.merge!(:conditions => {:created_at => Blog.get_range(params[:month])}) unless params[:month].nil?
    options.merge!(:conditions => {:category => params[:category]}) unless params[:category].nil?
    @blogs = Blog.paginate(:all, options)
    @months = Blog.seperate_by_months
  end

  def new
    @blog = Blog.new
    render :layout => 'editor'
  end

  def create
    @blog = Blog.new(params[:blog])

    if @blog.save
      redirect_to blogs_path
    else
      render :action => 'new'
    end
  end

  def show
    @images = @blog.images.enabled_images
    @months = Blog.seperate_by_months
  end

  def edit
    render :layout => 'editor'
  end

  def update
    if @blog.update_attributes(params[:blog])
      redirect_to blogs_path
    else
      render :action => 'edit'
    end
  end

  private

  def get_blog
    @blog = Blog.find(params[:id])
  end
end
