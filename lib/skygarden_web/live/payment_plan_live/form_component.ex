defmodule SkygardenWeb.PaymentPlanLive.FormComponent do
  use SkygardenWeb, :live_component

  alias Skygarden.Payments

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage payment_plan records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="payment_plan-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:installments]} type="number" label="Installments" />
        <.input field={@form[:interest]} type="number" label="Interest" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Payment plan</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{payment_plan: payment_plan} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Payments.change_payment_plan(payment_plan))
     end)}
  end

  @impl true
  def handle_event("validate", %{"payment_plan" => payment_plan_params}, socket) do
    changeset = Payments.change_payment_plan(socket.assigns.payment_plan, payment_plan_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"payment_plan" => payment_plan_params}, socket) do
    save_payment_plan(socket, socket.assigns.action, payment_plan_params)
  end

  defp save_payment_plan(socket, :edit, payment_plan_params) do
    case Payments.update_payment_plan(socket.assigns.payment_plan, payment_plan_params) do
      {:ok, payment_plan} ->
        notify_parent({:saved, payment_plan})

        {:noreply,
         socket
         |> put_flash(:info, "Payment plan updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_payment_plan(socket, :new, payment_plan_params) do
    case Payments.create_payment_plan(payment_plan_params) do
      {:ok, payment_plan} ->
        notify_parent({:saved, payment_plan})

        {:noreply,
         socket
         |> put_flash(:info, "Payment plan created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
