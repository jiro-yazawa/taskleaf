class Admin::UsersController < ApplicationController
  require 'sendgrid-ruby'
  include SendGrid

  before_action :require_admin

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      send_email(@user)
      redirect_to admin_users_url, notice: "ユーザー「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "ユーザー「#{@user.name}」を更新しました。"
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_url, notice: "ユーザー「#{@user.name}」を削除しました。"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end

  def send_email(user)
    data = JSON.parse('{
      "personalizations": [
        {
          "to": [
            {
              "email": "' + user.email + '"
            }
          ],
          "subject": "Hello World from the SendGrid Ruby Library!"
        }
      ],
      "from": {
        "email": "test@example.com"
      },
      "content": [
        {
          "type": "text/plain",
          "value": "' + login_path  + '"
        }
      ]
    }')

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._("send").post(request_body: data)
    puts response.status_code
    puts response.body
    puts response.headers    
  end
end
