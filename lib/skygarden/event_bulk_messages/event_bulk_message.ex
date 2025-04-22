defmodule Skygarden.EventBulkMessages.EventBulkMessage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "event_bulk_messages" do
    field :active, :boolean, default: false
    field :text, :string
    field :sent, :boolean, default: false
    field :send_at, :naive_datetime
    field :number_of_users_sent_to, :integer
    field :send_via, :string
    field :send_to_a_specific_ticket_group, :boolean, default: false
    belongs_to :user, Skygarden.Accounts.User
    belongs_to :event, Skygarden.Events.Event
    belongs_to :ticket_type, Skygarden.TicketTypes.TicketType


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(event_bulk_message, attrs) do
    event_bulk_message
    |> cast(attrs, [
      :text,
      :send_at,
      :active,
      :sent,
      :number_of_users_sent_to,
      :ticket_type_id,
      :send_via,
      :send_to_a_specific_ticket_group,
      :user_id,
      :event_id,
      ])
    |> validate_required([
      :text,
      :send_at,
      :active,
      :sent,
      :number_of_users_sent_to,
      :ticket_type_id,
      :send_via,
      :send_to_a_specific_ticket_group,
      :user_id,
      :event_id,
      ])
      |> send_at_later_than_now()
  end

  defp send_at_later_than_now(changeset)do
    send_at = get_field(changeset, :send_at)

    if is_nil(send_at) do
      changeset
    else
      now =
        DateTime.utc_now()

      send_at =
        DateTime.from_naive!(send_at, "Etc/UTC")

        if send_at < now do
          add_error(changeset, :send_at, "Send at must be later than now")
        else
          changeset
        end
    end
  end
end
