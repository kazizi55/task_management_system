class LabelsController < ApplicationController
  before_action :find_label, only: [:show, :edit, :update, :destroy]

  def index
    @labels = Label.all.page(params[:page]).per(10)
  end

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    @label.valid?
    @label.save!
    redirect_to labels_path, notice: "ラベルを追加しました" 
  rescue => e
    logger.error e 
    logger.error e.backtrace.join("\n") 
    flash.now[:alert] = "登録に失敗しました"
    render 'new'
  end

  def update
    @label.valid?
    @label.update!(label_params)
    redirect_to labels_path, notice: "ラベルを修正しました"
  rescue => e
    logger.error e 
    logger.error e.backtrace.join("\n") 
    flash.now[:alert] = "更新に失敗しました"
    render 'edit'
  end

  def destroy
    @label.destroy!
    redirect_to labels_path, notice: "ラベルを削除しました"
  rescue => e
    logger.error e 
    logger.error e.backtrace.join("\n") 
    flash.now[:alert] = "削除に失敗しました"
    render 'show'
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end

  def find_label
    @label = Label.find(params[:id])
  end
end
