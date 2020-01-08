class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = Task.all.order(created_at: :desc)
    #@articles = Kaminari.paginate_array(@tasks).page(params[:page]).per(3)
    @tasks = Task.all.page(params[:page])
    # if params[:page] == "1"
    #@tasks = Kaminari.paginate_array(@tasks).page(params[:page]).per(3)
    # end
    # f params[:page] == "2"
    #   @tasks = Kaminari.paginate_array(@tasks).page(params[:page]).per(3)
    # end
    # if params[:page] == "3"
    #   @tasks = Kaminari.paginate_array(@tasks).page(params[:page]).per(3)
    # end
    #binding.pry
    #binding.prya
   
      if params[:sort_expired]
        @tasks = Task.all.order('deadline desc').page(params[:page])
      end
      if params[:task]
        if params[:task][:search]#検索フォーム or 検索フーム以外のリンクから送られてきたものなのかの判断をする。
          @tasks = Task.where(['title LIKE ? AND status LIKE ?', "%#{params[:task][:title]}%", "%#{params[:task][:status]}%"] )
        end
      end

    if params[:sort_expired2]
      @tasks = Task.all.order('priority desc').page(params[:page])
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save

    redirect_to tasks_path, notice: "タスクを登録しました"
    else
    render :new
    end
  end

  def show
   @task = Task.find(params[:id])
  end

  def edit 
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました"
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
