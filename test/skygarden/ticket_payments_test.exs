defmodule Skygarden.TicketPaymentsTest do
  use Skygarden.DataCase

  alias Skygarden.TicketPayments

  describe "ticket_payments" do
    alias Skygarden.TicketPayments.TicketPayment

    import Skygarden.TicketPaymentsFixtures

    @invalid_attrs %{price: nil, phone_number: nil, email: nil, payment_method: nil, transaction_id: nil}

    test "list_ticket_payments/0 returns all ticket_payments" do
      ticket_payment = ticket_payment_fixture()
      assert TicketPayments.list_ticket_payments() == [ticket_payment]
    end

    test "get_ticket_payment!/1 returns the ticket_payment with given id" do
      ticket_payment = ticket_payment_fixture()
      assert TicketPayments.get_ticket_payment!(ticket_payment.id) == ticket_payment
    end

    test "create_ticket_payment/1 with valid data creates a ticket_payment" do
      valid_attrs = %{price: 120.5, phone_number: "some phone_number", email: "some email", payment_method: "some payment_method", transaction_id: "some transaction_id"}

      assert {:ok, %TicketPayment{} = ticket_payment} = TicketPayments.create_ticket_payment(valid_attrs)
      assert ticket_payment.price == 120.5
      assert ticket_payment.phone_number == "some phone_number"
      assert ticket_payment.email == "some email"
      assert ticket_payment.payment_method == "some payment_method"
      assert ticket_payment.transaction_id == "some transaction_id"
    end

    test "create_ticket_payment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TicketPayments.create_ticket_payment(@invalid_attrs)
    end

    test "update_ticket_payment/2 with valid data updates the ticket_payment" do
      ticket_payment = ticket_payment_fixture()
      update_attrs = %{price: 456.7, phone_number: "some updated phone_number", email: "some updated email", payment_method: "some updated payment_method", transaction_id: "some updated transaction_id"}

      assert {:ok, %TicketPayment{} = ticket_payment} = TicketPayments.update_ticket_payment(ticket_payment, update_attrs)
      assert ticket_payment.price == 456.7
      assert ticket_payment.phone_number == "some updated phone_number"
      assert ticket_payment.email == "some updated email"
      assert ticket_payment.payment_method == "some updated payment_method"
      assert ticket_payment.transaction_id == "some updated transaction_id"
    end

    test "update_ticket_payment/2 with invalid data returns error changeset" do
      ticket_payment = ticket_payment_fixture()
      assert {:error, %Ecto.Changeset{}} = TicketPayments.update_ticket_payment(ticket_payment, @invalid_attrs)
      assert ticket_payment == TicketPayments.get_ticket_payment!(ticket_payment.id)
    end

    test "delete_ticket_payment/1 deletes the ticket_payment" do
      ticket_payment = ticket_payment_fixture()
      assert {:ok, %TicketPayment{}} = TicketPayments.delete_ticket_payment(ticket_payment)
      assert_raise Ecto.NoResultsError, fn -> TicketPayments.get_ticket_payment!(ticket_payment.id) end
    end

    test "change_ticket_payment/1 returns a ticket_payment changeset" do
      ticket_payment = ticket_payment_fixture()
      assert %Ecto.Changeset{} = TicketPayments.change_ticket_payment(ticket_payment)
    end
  end
end
