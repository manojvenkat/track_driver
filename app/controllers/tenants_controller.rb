class TenantsController < ApplicationController
  before_action :admin_user, only: [:index, :edit, :update, :destroy]
  
  def index
    @tenants = Tenant.paginate(page: params[:page])
  end
  
  def show
    @tenant = Tenant.find(params[:id])
    @drivers = @tenant.drivers
  end
  
  def new
    @tenant = Tenant.new
  end
  
  def create
    @tenant = Tenant.new(tenant_params)
    if @tenant.save
      flash[:info] = "Tenant successfully created!"
      redirect_to tenants_url
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @tenant.update_attributes(tenant_params)
      flash[:success] = "Profile updated"
      redirect_to @tenant
    else
      render 'edit'
    end
  end
  
  def destroy
    Tenant.find(params[:id]).destroy
    flash[:success] = "tenant deleted"
    redirect_to tenants_url
  end

  private
    
    def tenant_params
      params.require(:tenant).permit(:name, :city, :email)
    end

    # Confirms an admin tenant.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end  
end