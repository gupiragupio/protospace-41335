class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  def index
    @prototypes = Prototype.all
  end
  
  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to '/'
    else
      render :new
    end
  end

  
  def show
      @prototype = Prototype.find(params[:id])
      @comments = @prototype.comments.includes(:user)
      @comment = Comment.new
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype), notice: 'プロトタイプが更新されました。'
    else
      render :edit 
    end
  end

  def edit
    @prototype = Prototype.find(params[:id])

    unless @prototype.user == current_user
      redirect_to root_path, alert: '編集権限がありません。'
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    if @prototype.destroy
      redirect_to root_path, notice: 'プロトタイプが削除されました。'
    else
      redirect_to prototype_path(@prototype), alert: '削除に失敗しました。'
    end
  end

  

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image)
           .merge(user_id: current_user.id)
  end
end
