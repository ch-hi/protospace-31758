class PrototypesController < ApplicationController
  before_action :set_prototype, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]

  def index
    # @prototype = Prototype.all #prototypeテーブルの全てのレコードをインスタンス変数に代入、ビューに渡す
    @prototypes = Prototype.includes(:user)
    # @prototypes = prototypes.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create  
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end    
  end

  def show
    # @prototype = Prototype.find(params[:id])　before_actionのset_tweetメソッドで処理を前にしている
    @comment = Comment.new
    @comments = @prototype.comments #投稿に紐づく全てのコメントを代入
  end

  def edit
    #before_actionで処理している
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end
  end

  def destroy
    if @prototype.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id) #参考：curriculums/4861
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def contributor_confirmation
    redirect_to root_path unless current_user == @prototype.user
  end 
end