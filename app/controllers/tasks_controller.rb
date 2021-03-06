class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_login!
  def index
    #@articles = Kaminari.paginate_array(@tasks).page(params[:page]).per(3)
    # if params[:page] == "1"
    @tasks = Task.all.order(created_at: :desc).page(params[:page])
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
          @middles = Middle.where(label_id: params[:task][:middles_label_ids]).pluck(:task_id) 
          #middlesテーブルにあるlabel_idを基にmiddlesテーブルのtask_idを取得する
          if @middles == []
            #binding.pry
            @tasks = Task.all.order(created_at: :desc).page(params[:page])
          else
          @tasks = Task.where(id: @middles)
          end
          #id: task_idからtask情報を取得する。これで、ラベルによる検索を行う
          @tasks = @tasks.where(['title LIKE ? AND status LIKE ?', "%#{params[:task][:title]}%", "%#{params[:task][:status]}%"] ).page(params[:page])
        end
      end

    if params[:sort_expired2]
      @tasks = Task.all.order('priority desc').page(params[:page])
    end
  end

  def new
    @task = Task.new
    #@label = Label.new
  end

  def create
    #@task = Task.new(task_params)
    #@task.user_id = current_user.id
    @task = current_user.tasks.build(task_params)
    #binding.pry
    if @task.save
    #binding.pry
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
   # binding.pry
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました"
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :priority, middles_label_ids: [])
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
