defmodule PhxPlaygroundWeb.Services.UserService do
  def create({name, id, gender}) do
    %{name: name, id: id, gender: gender} |> IO.inspect
  end

end
