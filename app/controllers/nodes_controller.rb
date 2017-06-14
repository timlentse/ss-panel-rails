class NodesController < ApplicationController
  before_action :check_in?
  before_action :set_node_params, only: [:update]

  def new
    @node = Node.new
  end

  def create
    @node = Node.new(name: node_params[:name], info: node_params[:info], server: node_params[:server], method: node_params[:method], cata: cata)
    if @node.save
      redirect_to '/admins/node', notice: '新建成功!'
    else
      flash.now[:alert] = @node.errors.inspect
      render :new
    end
  end

  def edit
    @node = Node.find_by_id(@params[:id])
  end

  def update
    @node = Node.find_by_id(@params[:id])
    if @node.update(@node_params)
      redirect_to '/admins/node', notice: '更改成功!'
    else
      flash.now[:alert] = @node.errors.inspect
      render :edit
    end
  end

  def destroy
    @node = Node.find_by_id(@params[:id])
    if @node.destroy
      redirect_to '/admins/node', notice: '删除成功!'
    else
      flash.now[:alert] = @node.errors.inspect
      render 'admins/node'
    end
  end

  private

  def set_node_params
    @node_params = params.require(:node).permit(:name, :info, :server, :method, :cata)
    cata = @node_params[:cata] == '公开' ? 1 : 0
    @node_params[:cata] = cata
  end
end
