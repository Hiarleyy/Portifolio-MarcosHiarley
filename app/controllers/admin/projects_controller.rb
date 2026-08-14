class Admin::ProjectsController < Admin::BaseController
  before_action :set_project, only: [:edit, :update, :destroy]

  def index
    @projects = Project.ordered
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to admin_projects_path, notice: "Projeto criado com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to admin_projects_path, notice: "Projeto atualizado com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.screenshot.purge if @project.screenshot.attached?
    @project.destroy
    redirect_to admin_projects_path, notice: "Projeto removido com sucesso!"
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :title_en, :description_en, :technologies, :live_url, :github_url, :featured, :position, :screenshot)
  end
end
