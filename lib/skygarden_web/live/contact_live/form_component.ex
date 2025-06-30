defmodule SkygardenWeb.ContactLive.FormComponent do
  use SkygardenWeb, :live_component

  alias Skygarden.Contacts

  @impl true
  def render(assigns) do
    ~H"""
    <section class="w-full mx-auto">
      <div class="flex flex-col items-center justify-center py-8 max-w-[90%] mx-auto">
        <h2 class="text-[32px] md:text[56px] font-bold mb-4">Contact Form</h2>
        <p class="text-gray-600 mb-6 text-[16px] md:text-[18px]">Have questions or need assistance? Our team is here to help you with any inquiries you may have.</p>
      </div>
      <div class ="">

      </div>

      <%!-- <.header>
        {@title}
        <:subtitle>Use this form to manage contact records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="contact-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:first_name]} type="text" label="First name" />
        <.input field={@form[:last_name]} type="text" label="Last name" />
        <.input field={@form[:email]} type="text" label="Email" />
        <.input field={@form[:phone]} type="text" label="Phone" />
        <.input field={@form[:subject]} type="text" label="Subject" />
        <.input field={@form[:message]} type="text" label="Message" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Contact</.button>
        </:actions>
      </.simple_form> --%>


    </section>
    """
  end

  @impl true
  def update(%{contact: contact} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Contacts.change_contact(contact))
     end)}
  end

  @impl true
  def handle_event("validate", %{"contact" => contact_params}, socket) do
    changeset = Contacts.change_contact(socket.assigns.contact, contact_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"contact" => contact_params}, socket) do
    save_contact(socket, socket.assigns.action, contact_params)
  end

  defp save_contact(socket, :edit, contact_params) do
    case Contacts.update_contact(socket.assigns.contact, contact_params) do
      {:ok, contact} ->
        notify_parent({:saved, contact})

        {:noreply,
         socket
         |> put_flash(:info, "Contact updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_contact(socket, :new, contact_params) do
    case Contacts.create_contact(contact_params) do
      {:ok, contact} ->
        notify_parent({:saved, contact})

        {:noreply,
         socket
         |> put_flash(:info, "Contact created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
