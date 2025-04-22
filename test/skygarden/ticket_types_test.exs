defmodule Skygarden.TicketTypesTest do
  use Skygarden.DataCase

  alias Skygarden.TicketTypes

  describe "ticket_types" do
    alias Skygarden.TicketTypes.TicketType

    import Skygarden.TicketTypesFixtures

    @invalid_attrs %{active: nil, name: nil, description: nil, price: nil, activate_on: nil, deactivate_on: nil, ticket_cap: nil, admits: nil, display_bnpl_option: nil}

    test "list_ticket_types/0 returns all ticket_types" do
      ticket_type = ticket_type_fixture()
      assert TicketTypes.list_ticket_types() == [ticket_type]
    end

    test "get_ticket_type!/1 returns the ticket_type with given id" do
      ticket_type = ticket_type_fixture()
      assert TicketTypes.get_ticket_type!(ticket_type.id) == ticket_type
    end

    test "create_ticket_type/1 with valid data creates a ticket_type" do
      valid_attrs = %{active: true, name: "some name", description: "some description", price: 120.5, activate_on: ~N[2025-04-21 10:06:00], deactivate_on: ~N[2025-04-21 10:06:00], ticket_cap: 42, admits: 42, display_bnpl_option: true}

      assert {:ok, %TicketType{} = ticket_type} = TicketTypes.create_ticket_type(valid_attrs)
      assert ticket_type.active == true
      assert ticket_type.name == "some name"
      assert ticket_type.description == "some description"
      assert ticket_type.price == 120.5
      assert ticket_type.activate_on == ~N[2025-04-21 10:06:00]
      assert ticket_type.deactivate_on == ~N[2025-04-21 10:06:00]
      assert ticket_type.ticket_cap == 42
      assert ticket_type.admits == 42
      assert ticket_type.display_bnpl_option == true
    end

    test "create_ticket_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TicketTypes.create_ticket_type(@invalid_attrs)
    end

    test "update_ticket_type/2 with valid data updates the ticket_type" do
      ticket_type = ticket_type_fixture()
      update_attrs = %{active: false, name: "some updated name", description: "some updated description", price: 456.7, activate_on: ~N[2025-04-22 10:06:00], deactivate_on: ~N[2025-04-22 10:06:00], ticket_cap: 43, admits: 43, display_bnpl_option: false}

      assert {:ok, %TicketType{} = ticket_type} = TicketTypes.update_ticket_type(ticket_type, update_attrs)
      assert ticket_type.active == false
      assert ticket_type.name == "some updated name"
      assert ticket_type.description == "some updated description"
      assert ticket_type.price == 456.7
      assert ticket_type.activate_on == ~N[2025-04-22 10:06:00]
      assert ticket_type.deactivate_on == ~N[2025-04-22 10:06:00]
      assert ticket_type.ticket_cap == 43
      assert ticket_type.admits == 43
      assert ticket_type.display_bnpl_option == false
    end

    test "update_ticket_type/2 with invalid data returns error changeset" do
      ticket_type = ticket_type_fixture()
      assert {:error, %Ecto.Changeset{}} = TicketTypes.update_ticket_type(ticket_type, @invalid_attrs)
      assert ticket_type == TicketTypes.get_ticket_type!(ticket_type.id)
    end

    test "delete_ticket_type/1 deletes the ticket_type" do
      ticket_type = ticket_type_fixture()
      assert {:ok, %TicketType{}} = TicketTypes.delete_ticket_type(ticket_type)
      assert_raise Ecto.NoResultsError, fn -> TicketTypes.get_ticket_type!(ticket_type.id) end
    end

    test "change_ticket_type/1 returns a ticket_type changeset" do
      ticket_type = ticket_type_fixture()
      assert %Ecto.Changeset{} = TicketTypes.change_ticket_type(ticket_type)
    end
  end
end
