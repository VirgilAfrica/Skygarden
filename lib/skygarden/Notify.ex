defmodule Skygarden.Notify do
  alias Skygarden.Tickets
  alias Skygarden.Accounts
  def api_url(), do: "https://api.tiaraconnect.io/api/messaging/sendsms"

  def sms_headers(),
    do: [
      {
        "Content-Type",
        "application/json"
      },
      {
        "Authorization",
        "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyOTAiLCJvaWQiOjI5MCwidWlkIjoiYWUzMGRjZTItMjIzYi00ODUzLWJmMDItNDE5ZWI2MzMzY2Y5IiwiYXBpZCI6MTgzLCJpYXQiOjE2OTM1OTAzNDksImV4cCI6MjAzMzU5MDM0OX0.mG9d0tTkmx49OQKMKQFYKnIQMHFQEIckHBnGe5jTjg3fU95aHLxrtouqsPGr7Yi3GKFt674_ImiLtJavAa4OIw"
      }
    ]

  def send_sms(message, phone_number) do
    sms_url = api_url()
    sms_headers = sms_headers()

    sms_body =
      %{
        "from" => "TIARACONECT",
        "to" => phone_number,
        "message" => message,
        "refId" => "09wiwu088e" # to change
      }
      |> Jason.encode!()

    HTTPoison.post(sms_url, sms_body, sms_headers)
  end

  def send_bulk_email(text, email, ticket_id) do
    ticket = Tickets.get_ticket_and_ticket_type_and_event(ticket_id)

    header = [
      {"Authorization",
       "Bearer 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"},
      {"Content-Type", "application/json"},
      {"Accept", "application/json"}
    ]

    body = %{
      "from" => %{
        "email" => "New Message from #{ticket.event.name}!"
      },
      "personalizations" => [
        %{
          "to" => [
            %{"email" => email}
          ],
          "dynamic_template_data" => %{
            "text" => text
          }
        }
      ],
      "template_id" => "d-8bba633bd52a4c3fb10ae87c4c6ff08a"
    }

    case HTTPoison.post(
           "https://api.sendgrid.com/v3/mail/send",
           Jason.encode!(body),
           header
         ) do
      {:ok, %HTTPoison.Response{status_code: 200}} ->
        :ok

      _ ->
        {:error, "Failed to send bulk emails"}
    end
  end

  def send_email_for_full_payment(ticket_id) do
    ticket = Tickets.get_ticket_and_ticket_type_and_event(ticket_id)

    subject = "Your #{ticket.ticket_type.name}  to #{ticket.event.name}"
    message = get_text_for_full_payment(ticket, ticket.event)

    ticket_url =
      "https://skygarden.virgil.africa" <> "/tickets/#{ticket.ticketid}"

    url_text = "View Your Ticket"

    case send_message_with_gmail_api(subject, message, ticket_url, url_text, ticket.email) do
      {:ok, _response} -> :ok
      _ -> {:error, "Failed to send email"}
    end
  end

  def send_sms_for_full_payment(ticket_id) do
    ticket = Tickets.get_ticket_and_ticket_type_and_event(ticket_id)

    message = """
    Hello #{ticket.name}, You have successfully purchased a #{ticket.ticket_type.name}  to #{ticket.event.name}.
    You can access it by clicking on  #{"https://skygarden.virgil.africa/tickets/#{ticket.ticketid}"}
    We look forward to seeing you at the event.
    """

    case send_sms(message, ticket.phone_number) do
      {:ok, %HTTPoison.Response{status_code: 200}} ->
        :ok

      _ ->
        {:error, "Failed"}
    end
  end

  def send_email_for_bnpl_initial_payment(ticket_id) do
    ticket = Tickets.get_ticket_and_ticket_type_and_event(ticket_id)

    header = [
      {"Authorization",
       "Bearer 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"},
      {"Content-Type", "application/json"},
      {"Accept", "application/json"}
    ]

    body = %{
      "from" => %{
        "email" => "Your Buy Now Pay Later Ticket to #{ticket.event.name}"
      },
      "personalizations" => [
        %{
          "to" => [
            %{"email" => ticket.email}
          ],
          "dynamic_template_data" => %{
            "text" => get_text_for_bnpl_initial_payment(ticket, ticket.event),
            "url" =>
              Application.get_env(:Skygarden, :base_app_url) <>
                "/event/#{ticket.event_id}/top_up?ticket_id=#{ticket.ticketid}"
          }
        }
      ],
      "template_id" => "d-8bba633bd52a4c3fb10ae87c4c6ff08a"
    }

    case HTTPoison.post(
           "https://api.sendgrid.com/v3/mail/send",
           Jason.encode!(body),
           header
         ) do
      {:ok, %HTTPoison.Response{status_code: 200}} ->
        :ok

      _ ->
        {:error, "Failed"}
    end
  end

  def send_sms_for_bnpl_initial_payment(ticket_id) do
    ticket = Tickets.get_ticket_and_ticket_type_and_event(ticket_id)

    message = """
     Hello #{ticket.name}, You have successfully paid  for a Buy Now Pay Later #{ticket.ticket_type.name}  to #{ticket.event.name}.
    You have a remaining balance of #{ticket.remaining_price} , we will be sending you reminders .
    To topup your ticket , click on link #{"https://famua.virgil.africa/event/#{ticket.event_id}/top_up?ticket_id=#{ticket.ticketid}"} .
    We look forward to seeing you at the event
    """

    case send_sms(message, ticket.phone_number) do
      {:ok, %HTTPoison.Response{status_code: 200}} ->
        :ok

      _ ->
        {:error, "Failed"}
    end
  end

  def send_reminder_email_for_bnpl(ticket_id) do
    ticket = Tickets.get_ticket_and_ticket_type_and_event(ticket_id)

    header = [
      {"Authorization",
       "Bearer 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"},
      {"Content-Type", "application/json"},
      {"Accept", "application/json"}
    ]

    body = %{
      "from" => %{
        "email" => "Your Reminder to Complete Ticket Payment for #{ticket.event.name}"
      },
      "personalizations" => [
        %{
          "to" => [
            %{"email" => ticket.email}
          ],
          "dynamic_template_data" => %{
            "text" => get_reminder_text(ticket, ticket.event),
            "url" =>
              "https://famua.virgil.africa/event/#{ticket.event_id}/top_up?ticket_id=#{ticket.ticketid}"
          }
        }
      ],
      "template_id" => "d-8bba633bd52a4c3fb10ae87c4c6ff08a"
    }

    HTTPoison.post(
      "https://api.sendgrid.com/v3/mail/send",
      Jason.encode!(body),
      header
    )
  end

  def send_new_user_email(user) do
    token = Accounts.get_reset_password_link_for_user(user)
    reset_link = "https://skygarden.virgil.africa/users/reset_password/" <> token

    subject = "Welcome to Skygarden Events!"

    message = """
    Hello #{user.email}, Welcome to Skygarden Events! We are excited to have you on board.
    Please click on the button below to reset your password and get started.
    """

    url_text = "Reset Password"

    send_message_with_gmail_api(subject, message, reset_link, url_text, user.email)
  end

  def send_reset_password_email(user) do
    token = Accounts.get_reset_password_link_for_user(user)
    reset_link = "https://skygarden.virgil.africa/users/reset_password/" <> token

    subject = "Reset Your Password - Skygarden Events"

    message = """
    Hello #{user.email}, Below is a link to reset your password.
    Please click on the button below to reset your password and get started.
    """

    url_text = "Reset Password"

    send_message_with_gmail_api(subject, message, reset_link, url_text, user.email)
  end

  def send_reminder_sms_for_bnpl(ticket_id) do
    ticket = Tickets.get_ticket_and_ticket_type_and_event(ticket_id)

    message = """
    Hello #{ticket.name}, We hope you are doing well.
    This is a reminder to complete your payment for  #{ticket.ticket_type.name}  to #{ticket.event.name}.
    You have a remaining balance of #{ticket.remaining_price} , we will be sending you reminders .
    To topup your ticket , click on link #{"https://skygarden.virgil.africa/event/#{ticket.event_id}/top_up?ticket_id=#{ticket.ticketid}"} .
    We look forward to seeing you at the event
    """

    send_sms(message, ticket.phone_number)
  end

  defp get_text_for_full_payment(ticket, event) do
    """
    Hello #{ticket.name}, You have successfully completed the purchase of a #{ticket.ticket_type.name}  to #{event.name}. Below is a button to view your ticket.
    We look forward to seeing you at the event.
    """
  end

  defp get_text_for_bnpl_initial_payment(ticket, event) do
    """
    Hello #{ticket.name}, You have successfully paid  for a Buy Now Pay Later #{ticket.ticket_type.name} to #{event.name}.
    You have a remaining balance of #{ticket.remaining_price} , we will be sending you reminders .
    To topup your ticket , click on the button below.
    We look forward to seeing you at the event

    """
  end

  defp get_reminder_text(ticket, event) do
    """
    Hello #{ticket.name}, We hope you are doing well.
    This is a reminder to complete your payment for  #{ticket.ticket_type.name}  to #{event.name}.
    You have a remaining balance of #{ticket.remaining_price} , we will be sending you reminders .
    To topup your ticket , click on the button below.
    We look forward to seeing you at the event

    """
  end

  def send_message_with_gmail_api(subject, text, url_to_send, url_text, to_email) do
    url = "https://gmail.googleapis.com/gmail/v1/users/me/messages/send"

    token = get_token("cloud.skygarden@gmail.com")

    headers = [
      {"Authorization", "Bearer #{token}"},
      {"Content-Type", "application/json"}
    ]

    html_email_content = """
    <!DOCTYPE html>
    <html>
    <head>
      <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,opsz,wght@0,9..40,100..1000;1,9..40,100..1000&family=Inter:wght@100..900&display=swap" rel="stylesheet">
     <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f9f9f9;
    }
    .container {
      text-align: center;
      padding: 20px;
      background-color: #ffffff;
      border: 1px solid #ddd;
      border-radius: 8px;
      max-width: 600px;
      margin: 50px auto;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    .image {
      max-width: 500px;
      border-radius: 8px;
    }
    .message {
      font-size: 18px;
      color: #333;
      margin: 20px 0;
    }
    .button {
      display: inline-block;
      padding: 12px 24px;
      font-size: 16px;
      color: #ffffff;
      background-color:red;
      text-decoration: none;
      border-radius: 5px;
      margin-top: 15px;
    }
    .link {
      font-size: 14px;
      color: red;
      margin-top: 10px;
      display: block;
    }
    </style>
    </head>
    <body>
    <div class="container">
    <p class="message" style="font-size: 18px; color: #333; margin: 20px 0;">
    #{text}
    </p>
    <a href="#{url_to_send}" class="button" style="display: inline-block; padding: 12px 24px; font-size: 16px; color: #ffffff; background-color: #8134AF; text-decoration: none; border-radius: 5px;">
    #{url_text}
    </a>
    <a href="#{url_to_send}" class="link" style="font-size: 14px; color: blue; margin-top: 10px; display: block;">
     #{url_to_send}
    </a>
    <p class="footer" style="font-size: 12px; color: #888; margin-top: 20px;">Powered by Virgil  | <a href="https://virgil.africa" style="color: #8134AF; text-decoration: none;">virgil.africa</a></p>
    </div>
    </body>
    </html>
    """

    # Email content needs to be base64url encoded RFC 2822 formatted message
    email_content =
      encode_email("cloud.skygarden.com", html_email_content, to_email, subject)

    body = %{raw: email_content}

    # Send the email using an HTTP client like HTTPoison
    HTTPoison.post(url, Jason.encode!(body), headers)
  end

  def get_token(email) do
    body = %{
      "email" => email
    }

    header = [
      {"Authorization",
       "Bearer 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"},
      {"Content-Type", "application/json"},
      {"Accept", "application/json"}
    ]

    case HTTPoison.post(
           "https://beastmode.10xbeast.com/api/get_token",
           Jason.encode!(body),
           header
         ) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Jason.decode!(body)["token"]

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end

  def encode_email(from_email, html_body, to_email, subject) do
    email = """
    From: #{from_email}
    To: #{to_email}
    Subject: #{subject}
    MIME-Version: 1.0
    Content-Type: text/html; charset=UTF-8

    #{html_body}
    """

    Base.url_encode64(email, padding: false)
  end
end
