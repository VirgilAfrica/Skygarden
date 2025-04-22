defmodule Skygarden.RemindersTest do
  use Skygarden.DataCase

  alias Skygarden.Reminders

  describe "reminders" do
    alias Skygarden.Reminders.Reminder

    import Skygarden.RemindersFixtures

    @invalid_attrs %{text: nil, sent_via: nil, email: nil, phone_number: nil}

    test "list_reminders/0 returns all reminders" do
      reminder = reminder_fixture()
      assert Reminders.list_reminders() == [reminder]
    end

    test "get_reminder!/1 returns the reminder with given id" do
      reminder = reminder_fixture()
      assert Reminders.get_reminder!(reminder.id) == reminder
    end

    test "create_reminder/1 with valid data creates a reminder" do
      valid_attrs = %{text: "some text", sent_via: "some sent_via", email: "some email", phone_number: "some phone_number"}

      assert {:ok, %Reminder{} = reminder} = Reminders.create_reminder(valid_attrs)
      assert reminder.text == "some text"
      assert reminder.sent_via == "some sent_via"
      assert reminder.email == "some email"
      assert reminder.phone_number == "some phone_number"
    end

    test "create_reminder/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reminders.create_reminder(@invalid_attrs)
    end

    test "update_reminder/2 with valid data updates the reminder" do
      reminder = reminder_fixture()
      update_attrs = %{text: "some updated text", sent_via: "some updated sent_via", email: "some updated email", phone_number: "some updated phone_number"}

      assert {:ok, %Reminder{} = reminder} = Reminders.update_reminder(reminder, update_attrs)
      assert reminder.text == "some updated text"
      assert reminder.sent_via == "some updated sent_via"
      assert reminder.email == "some updated email"
      assert reminder.phone_number == "some updated phone_number"
    end

    test "update_reminder/2 with invalid data returns error changeset" do
      reminder = reminder_fixture()
      assert {:error, %Ecto.Changeset{}} = Reminders.update_reminder(reminder, @invalid_attrs)
      assert reminder == Reminders.get_reminder!(reminder.id)
    end

    test "delete_reminder/1 deletes the reminder" do
      reminder = reminder_fixture()
      assert {:ok, %Reminder{}} = Reminders.delete_reminder(reminder)
      assert_raise Ecto.NoResultsError, fn -> Reminders.get_reminder!(reminder.id) end
    end

    test "change_reminder/1 returns a reminder changeset" do
      reminder = reminder_fixture()
      assert %Ecto.Changeset{} = Reminders.change_reminder(reminder)
    end
  end
end
