defmodule Skygarden.ContactsTest do
  use Skygarden.DataCase

  alias Skygarden.Contacts

  describe "contacts" do
    alias Skygarden.Contacts.Contact

    import Skygarden.ContactsFixtures

    @invalid_attrs %{message: nil, first_name: nil, last_name: nil, email: nil, phone: nil, subject: nil}

    test "list_contacts/0 returns all contacts" do
      contact = contact_fixture()
      assert Contacts.list_contacts() == [contact]
    end

    test "get_contact!/1 returns the contact with given id" do
      contact = contact_fixture()
      assert Contacts.get_contact!(contact.id) == contact
    end

    test "create_contact/1 with valid data creates a contact" do
      valid_attrs = %{message: "some message", first_name: "some first_name", last_name: "some last_name", email: "some email", phone: "some phone", subject: "some subject"}

      assert {:ok, %Contact{} = contact} = Contacts.create_contact(valid_attrs)
      assert contact.message == "some message"
      assert contact.first_name == "some first_name"
      assert contact.last_name == "some last_name"
      assert contact.email == "some email"
      assert contact.phone == "some phone"
      assert contact.subject == "some subject"
    end

    test "create_contact/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Contacts.create_contact(@invalid_attrs)
    end

    test "update_contact/2 with valid data updates the contact" do
      contact = contact_fixture()
      update_attrs = %{message: "some updated message", first_name: "some updated first_name", last_name: "some updated last_name", email: "some updated email", phone: "some updated phone", subject: "some updated subject"}

      assert {:ok, %Contact{} = contact} = Contacts.update_contact(contact, update_attrs)
      assert contact.message == "some updated message"
      assert contact.first_name == "some updated first_name"
      assert contact.last_name == "some updated last_name"
      assert contact.email == "some updated email"
      assert contact.phone == "some updated phone"
      assert contact.subject == "some updated subject"
    end

    test "update_contact/2 with invalid data returns error changeset" do
      contact = contact_fixture()
      assert {:error, %Ecto.Changeset{}} = Contacts.update_contact(contact, @invalid_attrs)
      assert contact == Contacts.get_contact!(contact.id)
    end

    test "delete_contact/1 deletes the contact" do
      contact = contact_fixture()
      assert {:ok, %Contact{}} = Contacts.delete_contact(contact)
      assert_raise Ecto.NoResultsError, fn -> Contacts.get_contact!(contact.id) end
    end

    test "change_contact/1 returns a contact changeset" do
      contact = contact_fixture()
      assert %Ecto.Changeset{} = Contacts.change_contact(contact)
    end
  end
end
