defmodule Skygarden.PaymentPlans.Paymentplan do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payment_plans" do
    field :installments, :integer
    field :interest, :float
    belongs_to :user, Skygarden.Accounts.User
    belongs_to :event, Skygarden.Events.Event

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(paymentplan, attrs) do
    paymentplan
    |> cast(attrs, [
      :installments,
      :interest,
      :user_id,
      :event_id
    ])
    |> validate_required([
      :installments,
      :interest,
      :user_id,
      :event_id
    ])
  end
end
