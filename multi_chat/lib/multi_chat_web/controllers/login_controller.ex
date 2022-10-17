defmodule MultiChatWeb.LoginController do
  use MultiChatWeb, :controller

  alias MultiChat.Accounts

  def login(conn, %{"email" => email, "password" => password}) do
    [email, password]
    |> IO.inspect(label: "login")

    _user_params = %{"email" => email, "password" => password}

    if user = Accounts.get_user_by_email_and_password(email, password) do
      token = Accounts.generate_user_session_token(user)

      conn
      |> render("login.json", token: token)

    else
      conn
      |> put_status(:unauthorized)
      |> render("error.json", errors: "Invalid email or password")
    end
  end
end
