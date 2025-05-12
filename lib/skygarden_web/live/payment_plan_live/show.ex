defmodule SkygardenWeb.PaymentPlanLive.Show do
  use SkygardenWeb, :live_view

  alias Skygarden.Payments

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:payment_plan, Payments.get_payment_plan!(id))}
  end

  defp page_title(:show), do: "Show Payment plan"
  defp page_title(:edit), do: "Edit Payment plan"
end
