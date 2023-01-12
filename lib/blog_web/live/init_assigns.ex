defmodule BlogWeb.InitAssigns do
  import Phoenix.Component
  import Phoenix.LiveView

  def on_mount(:user, _params, %{"user_token" => user_token}, socket) do
    socket =
      assign_new(socket, :current_user, fn ->
        Blog.Accounts.get_user_by_session_token(user_token)
      end)

    if socket.assigns.current_user do
      {:cont, socket}
    else
      {:halt, redirect(socket, to: "/")}
    end
  end
end
