defmodule Skygarden.EventUsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Skygarden.EventUsers` context.
  """

  @doc """
  Generate a event_user.
  """
  def event_user_fixture(attrs \\ %{}) do
    {:ok, event_user} =
      attrs
      |> Enum.into(%{
        role: "some role"
      })
      |> Skygarden.EventUsers.create_event_user()

    event_user
  end
end
