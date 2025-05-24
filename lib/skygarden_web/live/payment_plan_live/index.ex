defmodule SkygardenWeb.Payment_PlanLive.Index do
  use SkygardenWeb, :super_admin_live_view

  alias Skygarden.Payment_Plans
  alias Skygarden.PaymentPlans.Paymentplan
  alias Skygarden.Accounts
  alias Skygarden.Reminders

  @impl true
  def mount(_params, session, socket) do
    current_user =
      case session["user_token"] do
        nil -> nil
        token -> Accounts.get_user_by_session_token(token)
      end

    {:ok,
     socket
     |> stream(:payment_plans, Payment_Plans.list_payment_plans())
     |> assign(current_user: current_user)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Payment  plan")
    |> assign(:payment__plan, Payment_Plans.get_payment__plan!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Payment  plan")
    |> assign(:payment__plan, %Paymentplan{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Payment plans")
    |> assign(:payment__plan, nil)
  end

  @impl true
  def handle_info({SkygardenWeb.Payment_PlanLive.FormComponent, {:saved, payment__plan}}, socket) do
    {:noreply, stream_insert(socket, :payment_plans, payment__plan)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    payment__plan = Payment_Plans.get_payment__plan!(id)
    {:ok, _} = Payment_Plans.delete_payment__plan(payment__plan)

    {:noreply, stream_delete(socket, :payment_plans, payment__plan)}
  end
end
