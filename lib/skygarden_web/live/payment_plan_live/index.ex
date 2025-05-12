defmodule SkygardenWeb.PaymentPlanLive.Index do
  use SkygardenWeb, :live_view

  alias Skygarden.Payments
  alias Skygarden.Payments.PaymentPlan

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :payment_plans, Payments.list_payment_plans())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Payment plan")
    |> assign(:payment_plan, Payments.get_payment_plan!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Payment plan")
    |> assign(:payment_plan, %PaymentPlan{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Payment plans")
    |> assign(:payment_plan, nil)
  end

  @impl true
  def handle_info({SkygardenWeb.PaymentPlanLive.FormComponent, {:saved, payment_plan}}, socket) do
    {:noreply, stream_insert(socket, :payment_plans, payment_plan)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    payment_plan = Payments.get_payment_plan!(id)
    {:ok, _} = Payments.delete_payment_plan(payment_plan)

    {:noreply, stream_delete(socket, :payment_plans, payment_plan)}
  end
end
