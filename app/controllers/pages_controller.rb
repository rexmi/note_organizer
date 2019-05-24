class PagesController < ApplicationController
  include PagesHelper
  # layout 'application', :except => [:preview]
  def index
    # @s = markdown("
    #   ```javascript
    #   var s = 'hello world';
    #   console.log(s);
    #   ```")
    # puts @s
  end

  def preview
    @text = markdown(params[:text])
    puts '888888888888888'
    puts @text
    render :body => @text
  end

  def testpage
    @notes = Note.all
  end

  def craigslist

  end
end
