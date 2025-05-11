defmodule SkygardenWeb.TicketPaymentLive.FormComponent do
  use SkygardenWeb, :live_component

  alias Skygarden.Events

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage ticket_payment records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="ticket_payment-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:phone_number]} type="text" label="Phone number" />
        <.input field={@form[:email]} type="text" label="Email" />
        <.input field={@form[:payment_method]} type="text" label="Payment method" />
        <.input field={@form[:transaction_id]} type="text" label="Transaction" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Ticket payment</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{ticket_payment: ticket_payment} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Events.change_ticket_payment(ticket_payment))
     end)}
  end

  @impl true
  def handle_event("validate", %{"ticket_payment" => ticket_payment_params}, socket) do
    changeset = Events.change_ticket_payment(socket.assigns.ticket_payment, ticket_payment_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"ticket_payment" => ticket_payment_params}, socket) do
    save_ticket_payment(socket, socket.assigns.action, ticket_payment_params)
  end

  defp save_ticket_payment(socket, :edit, ticket_payment_params) do
    case Events.update_ticket_payment(socket.assigns.ticket_payment, ticket_payment_params) do
      {:ok, ticket_payment} ->
        notify_parent({:saved, ticket_payment})

        {:noreply,
         socket
         |> put_flash(:info, "Ticket payment updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_ticket_payment(socket, :new, ticket_payment_params) do
    case Events.create_ticket_payment(ticket_payment_params) do
      {:ok, ticket_payment} ->
        notify_parent({:saved, ticket_payment})

        {:noreply,
         socket
         |> put_flash(:info, "Ticket payment created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
