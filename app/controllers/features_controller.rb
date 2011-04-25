class FeaturesController < ApplicationController
  def attach_image
    image = Image.find(params[:image].to_i)
    feature = Feature.find(params[:to].to_i)

    valid = feature.update_attribute('images', feature.attach_a(image.attachment_file_name))
    output = render_to_string :partial => '/projects/right_col', :locals => {:project => feature.project}

    render :json => {:valid => valid, :output => output}
  end
end
