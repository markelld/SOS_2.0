class CocktailsController < ApplicationController
  before_action :set_cocktail, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show] 
  before_action :correct_user, only: [:edit, :update, :destroy] 


  # GET /cocktails or /cocktails.json
  def index 
    @q = Cocktail.ransack(params[:q])
    @cocktails = @q.result 
  end

  # GET /cocktails/1 or /cocktails/1.json
  def show
  end

  # GET /cocktails/new
  def new
    # @cocktail = Cocktail.new 
    @cocktail = current_user.cocktails.build
  end

  # GET /cocktails/1/edit
  def edit
  end

  # POST /cocktails or /cocktails.json
  def create
    # @cocktail = Cocktail.new(cocktail_params)
    @cocktail = current_user.cocktails.build(cocktail_params)
    respond_to do |format|
      if @cocktail.save
        format.html { redirect_to @cocktail, notice: "Cocktail was successfully created." }
        format.json { render :show, status: :created, location: @cocktail }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cocktail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cocktails/1 or /cocktails/1.json
  def update
    respond_to do |format|
      if @cocktail.update(cocktail_params)
        format.html { redirect_to @cocktail, notice: "Cocktail was successfully updated." }
        format.json { render :show, status: :ok, location: @cocktail }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cocktail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cocktails/1 or /cocktails/1.json
  def destroy
    @cocktail.destroy
    respond_to do |format|
      format.html { redirect_to cocktails_url, notice: "Cocktail was successfully destroyed." }
      format.json { head :no_content }
    end
  end 
  
  def correct_user
    @cocktail = current_user.cocktails.find_by(id: params[:id])
    redirect_to cocktails_path, notice: "Not Authorized To Edit This Friend" if @cocktail.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cocktail
      @cocktail = Cocktail.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cocktail_params
      params.require(:cocktail).permit(:name, :variety, :ingredients, :build, :user_id)
    end
end
