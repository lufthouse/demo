class BeaconsController < InheritedResources::Base
  
  before_action :authenticate_user!

  before_action :set_customer_and_installation

  before_action :set_beacon, only: [:show, :edit, :update, :destroy]

  def show
    @hash = Gmaps4rails.build_markers(@beacon) do |beacon, marker|
      marker.lat beacon.latitude
      marker.lng beacon.longitude
    end
  end

  def create
    @beacon = Beacon.new(beacon_params)
    set_beacon_installation_id_and_uuid
    respond_to do |format|
      if @beacon.save
        format.html { redirect_to beacon_path, notice: 'Beacon was successfully created.' }
        format.json { render :show, status: :created, location: beacon_path }
      else
        format.html { render :new }
        format.json { render json: @beacon.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @beacon.update(beacon_params)
        format.html { redirect_to beacon_path, notice: 'Beacon was successfully updated.' }
        format.json { render :show, status: :ok, location: beacon_path }
      else
        format.html { render :edit }
        format.json { render json: @beacon.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @beacon.destroy
    respond_to do |format|
      format.html { redirect_to installation_path, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_customer_and_installation
    @customer = Customer.find(params[:customer_id])
    @installation = Installation.find(params[:installation_id])
  end

  def set_beacon
    @beacon = Beacon.find(params[:id])
  end

  def set_beacon_installation_id_and_uuid
    @beacon.installation_id = @installation.id
    @beacon.uuid = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
  end

  def beacon_params
    params.require(:beacon).permit(
      :minor_id, :major_id, :latitude, :longitude, :content, :content_type, 
      :audio, :content_image, :uuid, :active
    )
  end

  # Path
  def installation_path
    customer_installation_path(@customer, @installation)
  end

  def beacon_path
    customer_installation_beacon_path(@customer, @installation, @beacon)
  end
end
