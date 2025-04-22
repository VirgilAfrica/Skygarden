defmodule Skygarden.EventPostersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Skygarden.EventPosters` context.
  """

  @doc """
  Generate a event_poster.
  """
  def event_poster_fixture(attrs \\ %{}) do
    {:ok, event_poster} =
      attrs
      |> Enum.into(%{
        image: "some image"
      })
      |> Skygarden.EventPosters.create_event_poster()

    event_poster
  end
end
