defmodule Skygarden.TicketPaymentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Skygarden.TicketPayments` context.
  """

  @doc """
  Generate a ticket_payment.
  """
  def ticket_payment_fixture(attrs \\ %{}) do
    {:ok, ticket_payment} =
      attrs
      |> Enum.into(%{
        email: "some email",
        payment_method: "some payment_method",
        phone_number: "some phone_number",
        price: 120.5,
        transaction_id: "some transaction_id"
      })
      |> Skygarden.TicketPayments.create_ticket_payment()

    ticket_payment
  end
end
