class GoalsController < ApplicationController
  before_action :ensure_login, only: %i[create new edit update]

  def index
    render :index
  end

  def new
    render :new
  end

  def create
    goal = Goal.new(goal_params)
    goal.author_id = current_user.id
    if goal.save
      flash[:success] = 'Created Goal'
      redirect_to goal_url(goal)
    else
      flash.now[:errors] = 'Invalid Values'
      render :new
    end
  end

  def show
    @goal = Goal.find(params[:id])
    user_has_access(@goal) ? (render :show) : (redirect_to goals_url)
  end

  def edit
    @goal = Goal.find(params[:id])
    render :edit
  end

  def update
    goal = Goal.find(params[:id])
    if belongs_to_user(goal) && goal.update_attributes(goal_params)
      flash[:success] = 'Edited Goal'
      redirect_to goal_url(goal)
    else
      flash.now[:errors] = 'You don\'t have permission to do this'
      redirect_to goal_url(goal)
    end
  end

  def destroy
    goal = Goal.find(params[:id])
    flash[:success] = 'Deleted Goal'
    goal.destroy
    redirect_to goals_url
  end

  private

  def goal_params
    params.require(:goal).permit(:text, :private?, :completed?)
  end
end
