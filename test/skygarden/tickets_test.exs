defmodule Skygarden.TicketsTest do
  use Skygarden.DataCase

  alias Skygarden.Tickets

  describe "tickets" do
    alias Skygarden.Tickets.Ticket

    import Skygarden.TicketsFixtures

    @invalid_attrs %{name: nil, phone_number: nil, email: nil, total_price: nil, remaining_price: nil, complimentary: nil, quantity: nil, ticketid: nil, transaction_id: nil, bnpl: nil}

    test "list_tickets/0 returns all tickets" do
      ticket = ticket_fixture()
      assert Tickets.list_tickets() == [ticket]
    end

    test "get_ticket!/1 returns the ticket with given id" do
      ticket = ticket_fixture()
      assert Tickets.get_ticket!(ticket.id) == ticket
    end

    test "create_ticket/1 with valid data creates a ticket" do
      valid_attrs = %{name: "some name", phone_number: "some phone_number", email: "some email", total_price: 120.5, remaining_price: 120.5, complimentary: true, quantity: 42, ticketid: "some ticketid", transaction_id: "some transaction_id", bnpl: true}

      assert {:ok, %Ticket{} = ticket} = Tickets.create_ticket(valid_attrs)
      assert ticket.name == "some name"
      assert ticket.phone_number == "some phone_number"
      assert ticket.email == "some email"
      assert ticket.total_price == 120.5
      assert ticket.remaining_price == 120.5
      assert ticket.complimentary == true
      assert ticket.quantity == 42
      assert ticket.ticketid == "some ticketid"
      assert ticket.transaction_id == "some transaction_id"
      assert ticket.bnpl == true
    end

    test "create_ticket/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tickets.create_ticket(@invalid_attrs)
    end

    test "update_ticket/2 with valid data updates the ticket" do
      ticket = ticket_fixture()
      update_attrs = %{name: "some updated name", phone_number: "some updated phone_number", email: "some updated email", total_price: 456.7, remaining_price: 456.7, complimentary: false, quantity: 43, ticketid: "some updated ticketid", transaction_id: "some updated transaction_id", bnpl: false}

      assert {:ok, %Ticket{} = ticket} = Tickets.update_ticket(ticket, update_attrs)
      assert ticket.name == "some updated name"
      assert ticket.phone_number == "some updated phone_number"
      assert ticket.email == "some updated email"
      assert ticket.total_price == 456.7
      assert ticket.remaining_price == 456.7
      assert ticket.complimentary == false
      assert ticket.quantity == 43
      assert ticket.ticketid == "some updated ticketid"
      assert ticket.transaction_id == "some updated transaction_id"
      assert ticket.bnpl == false
    end

    test "update_ticket/2 with invalid data returns error changeset" do
      ticket = ticket_fixture()
      assert {:error, %Ecto.Changeset{}} = Tickets.update_ticket(ticket, @invalid_attrs)
      assert ticket == Tickets.get_ticket!(ticket.id)
    end

    test "delete_ticket/1 deletes the ticket" do
      ticket = ticket_fixture()
      assert {:ok, %Ticket{}} = Tickets.delete_ticket(ticket)
      assert_raise Ecto.NoResultsError, fn -> Tickets.get_ticket!(ticket.id) end
    end

    test "change_ticket/1 returns a ticket changeset" do
      ticket = ticket_fixture()
      assert %Ecto.Changeset{} = Tickets.change_ticket(ticket)
    end
  end
end
