defmodule Skygarden.SubAccounts do
  @moduledoc """
  The SubAccounts context.
  """

  import Ecto.Query, warn: false
  alias Skygarden.Repo

  alias Skygarden.SubAccounts.SubAccount

  @doc """
  Returns the list of sub_accounts.

  ## Examples

      iex> list_sub_accounts()
      [%SubAccount{}, ...]

  """
  def list_sub_accounts do
    Repo.all(SubAccount)
  end

  @doc """
  Gets a single sub_account.

  Raises `Ecto.NoResultsError` if the Sub account does not exist.

  ## Examples

      iex> get_sub_account!(123)
      %SubAccount{}

      iex> get_sub_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sub_account!(id), do: Repo.get!(SubAccount, id)

  @doc """
  Creates a sub_account.

  ## Examples

      iex> create_sub_account(%{field: value})
      {:ok, %SubAccount{}}

      iex> create_sub_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sub_account(attrs \\ %{}) do
    %SubAccount{}
    |> SubAccount.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sub_account.

  ## Examples

      iex> update_sub_account(sub_account, %{field: new_value})
      {:ok, %SubAccount{}}

      iex> update_sub_account(sub_account, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sub_account(%SubAccount{} = sub_account, attrs) do
    sub_account
    |> SubAccount.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a sub_account.

  ## Examples

      iex> delete_sub_account(sub_account)
      {:ok, %SubAccount{}}

      iex> delete_sub_account(sub_account)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sub_account(%SubAccount{} = sub_account) do
    Repo.delete(sub_account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sub_account changes.

  ## Examples

      iex> change_sub_account(sub_account)
      %Ecto.Changeset{data: %SubAccount{}}

  """
  def change_sub_account(%SubAccount{} = sub_account, attrs \\ %{}) do
    SubAccount.changeset(sub_account, attrs)
  end
end
