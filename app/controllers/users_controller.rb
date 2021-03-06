class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy] 
  # GET /users
  # GET /users.json
  def index
    @users = User.all.paginate(:per_page=>10, :page=>params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Użytkownik został utworzony.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Szczegóły profilu zostały zaktualizowane.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    user_books = Book.find_by(user_id: @user.id)
      if user_books == nil
        @user.destroy
        flash[:notice] = "Użytkownik został usunięty."
        redirect_to users_url
      else
        flash[:danger] = "Użytkownik ma zarezerwowaną książkę, więc nie można go usunąć."
        redirect_to users_url
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :address, :phone, :is_admin, :is_deleted)
    end
  end
