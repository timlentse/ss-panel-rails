class Admin::NodesController < ApplicationController

  before_action :validate_admin, :get_traffic_usage, :check_in?
  before_action :set_node_params, only: [:update,:create]

  def index
    @nodes = Node.all
  end

  def new
  end

  def create
    @node = Node.new(@node_params)
    if @node.save
      redirect_to "/admin/nodes", notice: "新建成功!"
    else
      flash.now[:error] = @node.errors.messages
      render 'new'
    end
  end

  def edit
    @node = Node.find_by_id(params[:id])
    redirect_to '/404.html' and return unless @node
  end

  def update
    @node = Node.find_by_id(params[:id])
    if @node.update(@node_params)
      redirect_to "/admin/nodes", notice: "更改成功!"
    else
      flash.now[:error] = @node.errors.messages
      render 'edit'
    end
  end

  def destroy
    @node = Node.find_by_id(params[:id])
    if @node and @node.destroy
      redirect_to "/admin/nodes", notice: "删除成功!"
    elsif @node
      redirect_to "/admin/nodes",:flash=>{:error=>@node.errors.messages}
    else
      redirect_to "/admin/nodes",:flash=>{:error=>"节点不存在"}
    end
  end

  private 

  def set_node_params
    @node_params = params.require(:node).permit(:name,:info,:server,:method,:cata)
    cata = @node_params[:cata]=="公开" ? 1 : 0
    @node_params[:cata] = cata
  end

end
