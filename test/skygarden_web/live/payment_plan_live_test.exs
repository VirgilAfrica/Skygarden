defmodule SkygardenWeb.PaymentPlanLiveTest do
  use SkygardenWeb.ConnCase

  import Phoenix.LiveViewTest
  import Skygarden.PaymentsFixtures

  @create_attrs %{installments: 42, interest: 120.5}
  @update_attrs %{installments: 43, interest: 456.7}
  @invalid_attrs %{installments: nil, interest: nil}

  defp create_payment_plan(_) do
    payment_plan = payment_plan_fixture()
    %{payment_plan: payment_plan}
  end

  describe "Index" do
    setup [:create_payment_plan]

    test "lists all payment_plans", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/payment_plans")

      assert html =~ "Listing Payment plans"
    end

    test "saves new payment_plan", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/payment_plans")

      assert index_live |> element("a", "New Payment plan") |> render_click() =~
               "New Payment plan"

      assert_patch(index_live, ~p"/payment_plans/new")

      assert index_live
             |> form("#payment_plan-form", payment_plan: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#payment_plan-form", payment_plan: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/payment_plans")

      html = render(index_live)
      assert html =~ "Payment plan created successfully"
    end

    test "updates payment_plan in listing", %{conn: conn, payment_plan: payment_plan} do
      {:ok, index_live, _html} = live(conn, ~p"/payment_plans")

      assert index_live |> element("#payment_plans-#{payment_plan.id} a", "Edit") |> render_click() =~
               "Edit Payment plan"

      assert_patch(index_live, ~p"/payment_plans/#{payment_plan}/edit")

      assert index_live
             |> form("#payment_plan-form", payment_plan: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#payment_plan-form", payment_plan: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/payment_plans")

      html = render(index_live)
      assert html =~ "Payment plan updated successfully"
    end

    test "deletes payment_plan in listing", %{conn: conn, payment_plan: payment_plan} do
      {:ok, index_live, _html} = live(conn, ~p"/payment_plans")

      assert index_live |> element("#payment_plans-#{payment_plan.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#payment_plans-#{payment_plan.id}")
    end
  end

  describe "Show" do
    setup [:create_payment_plan]

    test "displays payment_plan", %{conn: conn, payment_plan: payment_plan} do
      {:ok, _show_live, html} = live(conn, ~p"/payment_plans/#{payment_plan}")

      assert html =~ "Show Payment plan"
    end

    test "updates payment_plan within modal", %{conn: conn, payment_plan: payment_plan} do
      {:ok, show_live, _html} = live(conn, ~p"/payment_plans/#{payment_plan}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Payment plan"

      assert_patch(show_live, ~p"/payment_plans/#{payment_plan}/show/edit")

      assert show_live
             |> form("#payment_plan-form", payment_plan: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#payment_plan-form", payment_plan: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/payment_plans/#{payment_plan}")

      html = render(show_live)
      assert html =~ "Payment plan updated successfully"
    end
  end
end
