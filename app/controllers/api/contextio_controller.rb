class Api::ContextioController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create
    json = JSON.parse(request.body.string)

    ReportMailer.email(FetchFaces.new(json["message_data"]["message_id"]).call).deliver_now
    head :ok
  end
end
