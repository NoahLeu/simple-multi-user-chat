defmodule MultiChatWeb.LoginView do
  use MultiChatWeb, :view

  def render("login.json", %{token: token}) do
    %{
      data: %{token: render_one(token, MultiChatWeb.LoginView, "token.json")},
      status: "success"
    }
  end

  def render("error.json", %{errors: errors}) do
    %{
      data: %{errors: errors},
      status: "error"
    }
  end

  def render("token.json", %{login: token}) do
    %{
      # token from byte to string
      token: Base.encode64(token)
    }
  end
end
