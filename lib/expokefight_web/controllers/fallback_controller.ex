defmodule ExpokefightWeb.FallbackController do
  use ExpokefightWeb, :controller
  alias Expokefight.Error
  alias ExpokefightWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
