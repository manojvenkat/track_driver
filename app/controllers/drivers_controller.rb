class DriversController < ApplicationController
  before_action :admin_user, only: [:index, :edit, :update, :destroy]
  
  def index
    @drivers = Driver.paginate(page: params[:page])
  end
  
  def show
    @driver = Driver.find(params[:id])
    @summary = @driver.summary
  end
  
  def new
    @driver = Driver.new
  end
  
  def create
    @driver = Driver.new(driver_params)
    if @driver.save
      flash[:info] = "Driver successfully created!"
      redirect_to drivers_url
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @driver.update_attributes(driver_params)
      flash[:success] = "Profile updated"
      redirect_to @driver
    else
      render 'edit'
    end
  end
  
  def destroy
    Driver.find(params[:id]).destroy
    flash[:success] = "driver deleted"
    redirect_to drivers_url
  end

  private
    
    def driver_params
      params.require(:driver).permit(:license_id)
    end

    # Confirms an admin driver.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end  
end