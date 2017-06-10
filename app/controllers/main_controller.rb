class MainController < ApplicationController

  def index
    return render html: '<div>html goes here</div>'.html_safe
  end
end
