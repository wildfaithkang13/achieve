class PoemsController < ApplicationController
  before_action :set_poem, only: [:show]
  def index
    @poems = Poem.all
    #ender json: @poems
  end

  def show
    #JSONのデータをパースする場合は以下のようにする
    #respond_to do |format|
      #format.html
      #format.json { render json: @poem } # jsonを指定した場合、jsonフォーマットで返す
    #end
    render json: @poem
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poem
      @poem = Poem.find(params[:id])
    end
end
