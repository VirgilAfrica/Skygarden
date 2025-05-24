defmodule SkygardenWeb.SubAccountLive.Index do
  use SkygardenWeb, :super_admin_live_view

  alias Skygarden.SubAccounts
  alias Skygarden.SubAccounts.SubAccount
  alias Skygarden.Accounts

  @impl true
  def mount(_params, _session, socket) do
    users_for_dropdown_selection = Accounts.list_users_for_dropdown_selection()

    {:ok,
     socket
     |> assign(:users_for_dropdown_selection, users_for_dropdown_selection)
     |> stream(:sub_accounts, SubAccounts.list_sub_accounts())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Sub account")
    |> assign(:sub_account, SubAccounts.get_sub_account!(id))
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
    sub_account = SubAccounts.get_sub_account!(id)
    {:ok, _} = SubAccounts.delete_sub_account(sub_account)

    {:noreply, stream_delete(socket, :sub_accounts, sub_account)}
  end
end
