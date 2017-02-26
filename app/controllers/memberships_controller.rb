class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]

	def index
    @memberships = Membership.all
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show    
  end

  def new
    @membership = Membership.new
    @beer_clubs = BeerClub.all - current_user.beer_clubs
  end

  def edit    
  end

  def create
    @membership = Membership.new(membership_params)
    @membership.user = current_user

    respond_to do |format|
      if not current_user.beer_clubs.include?  @membership.beer_club and @membership.save
        format.html { redirect_to @membership.beer_club, notice: "#{current_user.username}, welcome to the club!" }
        format.json { render :show, status: :created, location: @membership }
      else
        @beer_clubs = BeerClub.all - current_user.beer_clubs 
        format.html { render :new }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy    
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user.id), notice: 'Membership was successfully ended.' }
      format.json { head :no_content }
    end
  end
 


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:beer_club_id, :user_id)
    end

end