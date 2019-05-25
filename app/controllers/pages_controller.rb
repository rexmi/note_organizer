class PagesController < ApplicationController
  include PagesHelper
  include Assets::Scrap_Folder::Scrap_Logic

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
    @gigs = ScrapResult.where.not(content: nil).order(datetime: :desc)
    @no_content_gigs = ScrapResult.where(content: nil).size
  end

  private

end
