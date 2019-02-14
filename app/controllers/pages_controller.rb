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
end
