defmodule SkygardenWeb.SubAccountLive.FormComponent do
  use SkygardenWeb, :live_component

  alias Skygarden.Payments

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage sub_account records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="sub_account-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:account_name]} type="text" label="Account name" />
        <.input field={@form[:account_number]} type="text" label="Account number" />
        <.input field={@form[:currency]} type="text" label="Currency" />
        <.input field={@form[:settlement_bank]} type="text" label="Settlement bank" />
        <.input field={@form[:subaccount_code]} type="text" label="Subaccount code" />
        <.input field={@form[:percentage_split]} type="number" label="Percentage split" />
        <.input field={@form[:bank_code]} type="number" label="Bank code" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Sub account</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{sub_account: sub_account} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Payments.change_sub_account(sub_account))
     end)}
  end

  @impl true
  def handle_event("validate", %{"sub_account" => sub_account_params}, socket) do
    changeset = Payments.change_sub_account(socket.assigns.sub_account, sub_account_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"sub_account" => sub_account_params}, socket) do
    save_sub_account(socket, socket.assigns.action, sub_account_params)
  end

  defp save_sub_account(socket, :edit, sub_account_params) do
    case Payments.update_sub_account(socket.assigns.sub_account, sub_account_params) do
      {:ok, sub_account} ->
        notify_parent({:saved, sub_account})

        {:noreply,
         socket
         |> put_flash(:info, "Sub account updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_sub_account(socket, :new, sub_account_params) do
    case Payments.create_sub_account(sub_account_params) do
      {:ok, sub_account} ->
        notify_parent({:saved, sub_account})

        {:noreply,
         socket
         |> put_flash(:info, "Sub account created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
