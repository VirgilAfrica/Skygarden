defmodule Skygarden.RemindersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Skygarden.Reminders` context.
  """

  @doc """
  Generate a reminder.
  """
  def reminder_fixture(attrs \\ %{}) do
    {:ok, reminder} =
      attrs
      |> Enum.into(%{
        email: "some email",
        phone_number: "some phone_number",
        sent_via: "some sent_via",
        text: "some text"
      })
      |> Skygarden.Reminders.create_reminder()

    reminder
  end
end
