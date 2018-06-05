require 'screen_capture_handler'
class ScreenCapturesController < ApplicationController
  before_action :set_screen_capture, only: [:show, :update, :destroy]

  def create
    if params[:screen_capture][:service_url].present?
      @screen_capture_handler = ScreenCaptureHandler.new(params[:screen_capture][:service_url])
      @screen_capture = ScreenCapture.new(screen_capture_params)
      @screen_capture.file_name = @screen_capture_handler.file_name
      if @screen_capture.save
        render json: {img_url: "#{ENV['SERVER']}/screenshots/#{@screen_capture.file_name}"}, status: :created, location: @screen_capture
      else
        render json: @screen_capture.errors, status: :unprocessable_entity
      end
    else
      render json: {error: 'Please provide a valid service_url.'}
    end
  end

  def index
    render text: 'App is working'
  end

  private
    def set_screen_capture
      @screen_capture = ScreenCapture.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def screen_capture_params
      params.require(:screen_capture).permit(:service_url, :file_name)
    end
end
