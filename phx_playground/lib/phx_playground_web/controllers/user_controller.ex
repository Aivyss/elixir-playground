defmodule PhxPlaygroundWeb.UserController do
  use PhxPlaygroundWeb, :controller

  alias PhxPlaygroundWeb.Services.UserService, as: UserService

  action_fallback PhxPlaygroundWeb.FallbackController

  def create_user(conn, %{"name" => name, "id" => id, "gender" => gender}) do
      result = {name, id, gender} |> UserService.create
      conn
        |> put_status(:ok)
        |> put_resp_header("location", ~p"/api/users/")
        |> render(:created, result)
  end
end



"""
curl -iX POST http://localhost:4000/api/users \
   -H 'Content-Type: application/json' \
   -d '{"name": "John", "id": 1, "gender": "Male"}'
"""
