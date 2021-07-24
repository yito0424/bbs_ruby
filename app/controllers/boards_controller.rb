class BoardsController < ApplicationController
  before_action :set_target_board, only: %i[show edit update destroy]

  def index
    @boards = params[:tag_id].present? ? Tag.find(params[:tag_id]).boards : Board.all
    @boards = @boards.page(params[:page])
  end
  def new
    if @current_user
      @board = Board.new(flash[:board])
      @board[:user_id] = @current_user[:id]
    else
      redirect_to root_path
    end
  end
  def create
    board = Board.new(board_params)
    if board.save
      flash[:notice] = "「#{board.title}」の掲示板を作成しました"
      redirect_to board
    else
      redirect_to new_board_path, flash: {
        board: board,
        error_messages: board.errors.full_messages
      }
    end
  end

  def show
    @comment = Comment.new(board_id: @board.id)
    if @current_user
      @comment.user_id = @current_user.id
    end
  end


  def edit
    if @current_user
      unless @board && @board.user_id == @current_user.id
        redirect_to boards_path
      end
    else
      redirect_to root_path
    end

  end

  def update
    if @board.update(board_params)
      flash[:notice] = "「#{@board.title}」の掲示板を編集しました"
      redirect_to @board
    else
      redirect_to :back, flash: {
        board: @board,
        error_messages: @board.errors.full_messages
      }
    end
  end

  def destroy
    @board.destroy
    redirect_to boards_path, flash: {notice: "「#{@board.title}」の掲示板が削除されました"}
  end
  
  private

  def board_params
    params.require(:board).permit(:user_id, :title, :body, tag_ids: [])
  end

  def set_target_board
    @board = Board.find(params[:id])
  end
end
