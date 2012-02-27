class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update,:destroy]


  def index
    @users = User.all
    @title = "All users"
  end

  def new
    @user = User.new
    @title = "Sign up"
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def create

    @user = User.new(params[:user])
    if @user.save
      flash[:success]= "Welcome to the Sample App!"
      sign_in @user
      redirect_to @user

    else
      @title = "Sign up"
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    @title = "Edit user"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success]= "Profile  updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
    
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path, :flash[:success] = "User destroyed"
  end

  private

  def authenticate
    deny_access unless signed_in?
  end

  def deny_access
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless @user == current_user
  end

  
end
