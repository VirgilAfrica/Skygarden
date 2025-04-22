defmodule Skygarden.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Skygarden.Events` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        active: true,
        date: ~D[2025-04-21],
        description: "some description",
        end_time: ~T[14:00:00],
        location: "some location",
        name: "some name",
        poster_image: "some poster_image",
        remind_after: 42,
        remind_time: ~T[14:00:00],
        slug: "some slug",
        start_time: ~T[14:00:00]
      })
      |> Skygarden.Events.create_event()

    event
  end
end
