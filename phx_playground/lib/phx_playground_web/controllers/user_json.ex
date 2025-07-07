defmodule PhxPlaygroundWeb.UserJSON do
  def created(response)  do
    IO.puts "render json"
    response |> Map.take([:id, :gender, :name])
  end
end
