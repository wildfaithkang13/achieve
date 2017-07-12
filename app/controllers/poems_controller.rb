class PoemsController < ApplicationController
  before_action :set_poem, only: [:show]
  def index
    @poems = Poem.all
    render json: @poems
  end

  def show
    render json: @poem
    #JSONのデータをパースする場合は以下のようにする
    #respond_to do |format|
      #format.html
      #format.json { render json: @poem } # jsonを指定した場合、jsonフォーマットで返す
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poem
      @poem = Poem.find(params[:id])
    end
end
