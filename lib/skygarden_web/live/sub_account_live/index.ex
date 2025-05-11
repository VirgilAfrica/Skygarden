defmodule SkygardenWeb.SubAccountLive.Index do
  use SkygardenWeb, :live_view

  alias Skygarden.Payments
  alias Skygarden.Payments.SubAccount

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :sub_accounts, Payments.list_sub_accounts())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Sub account")
    |> assign(:sub_account, Payments.get_sub_account!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Sub account")
    |> assign(:sub_account, %SubAccount{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Sub accounts")
    |> assign(:sub_account, nil)
  end

  @impl true
  def handle_info({SkygardenWeb.SubAccountLive.FormComponent, {:saved, sub_account}}, socket) do
    {:noreply, stream_insert(socket, :sub_accounts, sub_account)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    sub_account = Payments.get_sub_account!(id)
    {:ok, _} = Payments.delete_sub_account(sub_account)

    {:noreply, stream_delete(socket, :sub_accounts, sub_account)}
  end
end
