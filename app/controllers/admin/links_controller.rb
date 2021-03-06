class Admin::LinksController < AdminController
  layout 'admin'

  def index
    @links = Link.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @links }
    end
  end

  def show
    @link = Link.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @link }
    end
  end

  def new
    @link = Link.new
    @category = LinkCategory.where(user_id: current_user.id)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @link }
    end
  end

  def edit
    @link = Link.find(params[:id])
    @category = LinkCategory.where(user_id: current_user.id)
  end

  def create
    link = Link.new(link_params)

    respond_to do |format|
      if link.save
        format.html { redirect_to admin_links_path, success: '创建成功' }
        format.json { render json: link, status: :created, location: admin_links_path }
      else
        format.html { render 'new' }
        format.json { render json: link.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @link = Link.find(params[:id])

    respond_to do |format|
      if @link.update_attributes(link_params)
        format.html { redirect_to admin_links_path, success: '更新成功' }
        format.json { head :no_content }
      else
        format.html { render 'edit' }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy

    respond_to do |format|
      format.html { redirect_to admin_links_path, info: '删除成功' }
      format.json { head :no_content }
    end
  end

  private

  def link_params
    params.require(:link).permit(:title, :href, :description, :link_category_id)
  end
end
