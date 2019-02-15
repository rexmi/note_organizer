class PagesController < ApplicationController
  include PagesHelper
  def index
    @s = markdown("
      ```javascript
      var s = 'hello world';
      console.log(s);
      ```")
    puts @s
  end

  def preview
    @text = markdown(params[:text])
    puts '888888888888888'
    puts @text
  end

  def testpage
  end
end
