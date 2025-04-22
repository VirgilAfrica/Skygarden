defmodule Skygarden.TicketTypesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Skygarden.TicketTypes` context.
  """

  @doc """
  Generate a ticket_type.
  """
  def ticket_type_fixture(attrs \\ %{}) do
    {:ok, ticket_type} =
      attrs
      |> Enum.into(%{
        activate_on: ~N[2025-04-21 10:06:00],
        active: true,
        admits: 42,
        deactivate_on: ~N[2025-04-21 10:06:00],
        description: "some description",
        display_bnpl_option: true,
        name: "some name",
        price: 120.5,
        ticket_cap: 42
      })
      |> Skygarden.TicketTypes.create_ticket_type()

    ticket_type
  end
end
