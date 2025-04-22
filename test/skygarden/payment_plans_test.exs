defmodule Skygarden.PaymentPlansTest do
  use Skygarden.DataCase

  alias Skygarden.PaymentPlans

  describe "payment_plans" do
    alias Skygarden.PaymentPlans.Paymentplan

    import Skygarden.PaymentPlansFixtures

    @invalid_attrs %{installments: nil, interest: nil}

    test "list_payment_plans/0 returns all payment_plans" do
      paymentplan = paymentplan_fixture()
      assert PaymentPlans.list_payment_plans() == [paymentplan]
    end

    test "get_paymentplan!/1 returns the paymentplan with given id" do
      paymentplan = paymentplan_fixture()
      assert PaymentPlans.get_paymentplan!(paymentplan.id) == paymentplan
    end

    test "create_paymentplan/1 with valid data creates a paymentplan" do
      valid_attrs = %{installments: 42, interest: 120.5}

      assert {:ok, %Paymentplan{} = paymentplan} = PaymentPlans.create_paymentplan(valid_attrs)
      assert paymentplan.installments == 42
      assert paymentplan.interest == 120.5
    end

    test "create_paymentplan/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PaymentPlans.create_paymentplan(@invalid_attrs)
    end

    test "update_paymentplan/2 with valid data updates the paymentplan" do
      paymentplan = paymentplan_fixture()
      update_attrs = %{installments: 43, interest: 456.7}

      assert {:ok, %Paymentplan{} = paymentplan} = PaymentPlans.update_paymentplan(paymentplan, update_attrs)
      assert paymentplan.installments == 43
      assert paymentplan.interest == 456.7
    end

    test "update_paymentplan/2 with invalid data returns error changeset" do
      paymentplan = paymentplan_fixture()
      assert {:error, %Ecto.Changeset{}} = PaymentPlans.update_paymentplan(paymentplan, @invalid_attrs)
      assert paymentplan == PaymentPlans.get_paymentplan!(paymentplan.id)
    end

    test "delete_paymentplan/1 deletes the paymentplan" do
      paymentplan = paymentplan_fixture()
      assert {:ok, %Paymentplan{}} = PaymentPlans.delete_paymentplan(paymentplan)
      assert_raise Ecto.NoResultsError, fn -> PaymentPlans.get_paymentplan!(paymentplan.id) end
    end

    test "change_paymentplan/1 returns a paymentplan changeset" do
      paymentplan = paymentplan_fixture()
      assert %Ecto.Changeset{} = PaymentPlans.change_paymentplan(paymentplan)
    end
  end
end
