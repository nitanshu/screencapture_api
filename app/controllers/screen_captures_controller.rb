class ScreenCapturesController < ApplicationController
  before_action :set_screen_capture, only: [:show, :update, :destroy]

  # GET /screen_captures
  def index
    @screen_captures = ScreenCapture.all

    render json: @screen_captures
  end

  # GET /screen_captures/1
  def show
    render json: @screen_capture
  end

  # POST /screen_captures
  def create
    if params[:screen_capture][:url].present?
      ScreenCapture.process_screen_capturing(params[:screen_capture][:url])
    end
    @screen_capture = ScreenCapture.new(screen_capture_params)

    if @screen_capture.save
      render json: @screen_capture, status: :created, location: @screen_capture
    else
      render json: @screen_capture.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /screen_captures/1
  def update
    if @screen_capture.update(screen_capture_params)
      render json: @screen_capture
    else
      render json: @screen_capture.errors, status: :unprocessable_entity
    end
  end

  # DELETE /screen_captures/1
  def destroy
    @screen_capture.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_screen_capture
      @screen_capture = ScreenCapture.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def screen_capture_params
      params.require(:screen_capture).permit(:url)
    end
end
