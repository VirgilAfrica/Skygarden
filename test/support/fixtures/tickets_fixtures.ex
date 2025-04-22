defmodule Skygarden.TicketsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Skygarden.Tickets` context.
  """

  @doc """
  Generate a ticket.
  """
  def ticket_fixture(attrs \\ %{}) do
    {:ok, ticket} =
      attrs
      |> Enum.into(%{
        bnpl: true,
        complimentary: true,
        email: "some email",
        name: "some name",
        phone_number: "some phone_number",
        quantity: 42,
        remaining_price: 120.5,
        ticketid: "some ticketid",
        total_price: 120.5,
        transaction_id: "some transaction_id"
      })
      |> Skygarden.Tickets.create_ticket()

    ticket
  end
end
