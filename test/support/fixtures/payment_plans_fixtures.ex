defmodule Skygarden.PaymentPlansFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Skygarden.PaymentPlans` context.
  """

  @doc """
  Generate a paymentplan.
  """
  def paymentplan_fixture(attrs \\ %{}) do
    {:ok, paymentplan} =
      attrs
      |> Enum.into(%{
        installments: 42,
        interest: 120.5
      })
      |> Skygarden.PaymentPlans.create_paymentplan()

    paymentplan
  end
end
