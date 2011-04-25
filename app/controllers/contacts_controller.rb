class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])

    respond_to do |format|
      format.html {}
      format.js do
        if @contact.save
          flash[:success] = "Your message has been sent."
          out = render_to_string :partial => 'success', :locals => {:contact => @contact}
        else
          flash[:warning] = "There are errors with the message you have submitted."
          out = render_to_string :partial => 'form', :locals => {:contact => @contact}
        end

        render :json => {:output => out}
      end
    end
  end
end
