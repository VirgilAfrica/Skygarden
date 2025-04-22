defmodule Skygarden.PaymentPlans do
  @moduledoc """
  The PaymentPlans context.
  """

  import Ecto.Query, warn: false
  alias Skygarden.Repo

  alias Skygarden.PaymentPlans.Paymentplan

  @doc """
  Returns the list of payment_plans.

  ## Examples

      iex> list_payment_plans()
      [%Paymentplan{}, ...]

  """
  def list_payment_plans do
    Repo.all(Paymentplan)
  end

  @doc """
  Gets a single paymentplan.

  Raises `Ecto.NoResultsError` if the Paymentplan does not exist.

  ## Examples

      iex> get_paymentplan!(123)
      %Paymentplan{}

      iex> get_paymentplan!(456)
      ** (Ecto.NoResultsError)

  """
  def get_paymentplan!(id), do: Repo.get!(Paymentplan, id)

  @doc """
  Creates a paymentplan.

  ## Examples

      iex> create_paymentplan(%{field: value})
      {:ok, %Paymentplan{}}

      iex> create_paymentplan(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_paymentplan(attrs \\ %{}) do
    %Paymentplan{}
    |> Paymentplan.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a paymentplan.

  ## Examples

      iex> update_paymentplan(paymentplan, %{field: new_value})
      {:ok, %Paymentplan{}}

      iex> update_paymentplan(paymentplan, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_paymentplan(%Paymentplan{} = paymentplan, attrs) do
    paymentplan
    |> Paymentplan.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a paymentplan.

  ## Examples

      iex> delete_paymentplan(paymentplan)
      {:ok, %Paymentplan{}}

      iex> delete_paymentplan(paymentplan)
      {:error, %Ecto.Changeset{}}

  """
  def delete_paymentplan(%Paymentplan{} = paymentplan) do
    Repo.delete(paymentplan)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking paymentplan changes.

  ## Examples

      iex> change_paymentplan(paymentplan)
      %Ecto.Changeset{data: %Paymentplan{}}

  """
  def change_paymentplan(%Paymentplan{} = paymentplan, attrs \\ %{}) do
    Paymentplan.changeset(paymentplan, attrs)
  end
end
