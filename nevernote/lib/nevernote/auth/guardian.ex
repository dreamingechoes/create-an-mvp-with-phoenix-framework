defmodule Nevernote.Guardian do
  use Guardian, otp_app: :nevernote

  import NevernoteWeb.Gettext

  alias Comeonin.Bcrypt
  alias Nevernote.Accounts

  def subject_for_token(resource, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]

    resource = Accounts.get_user!(id)
    {:ok, resource}
  end

  def authenticate_user(email, password) do
    email
    |> Accounts.get_user_by_email()
    |> check_password(password)
  end

  defp check_password(nil, _),
    do: {:error, gettext("Incorrect username or password")}

  defp check_password(user, password) do
    case Bcrypt.checkpw(password, user.password) do
      true -> {:ok, user}
      false -> {:error, gettext("Incorrect username or password")}
    end
  end
end
