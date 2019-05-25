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
    # vancouver = 'https://vancouver.craigslist.ca/search/cpg?'
    # kamloops = 'https://kamloops.craigslist.ca/search/cpg?'

    # generate_doc(kamloops)
    # process_city

    # f = File.open("html.txt")
    # @html = generate_dummy_doc f.read
    # gigs = get_all_rows(@html)
  end

  private

end
