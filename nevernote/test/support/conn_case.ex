defmodule NevernoteWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common datastructures and query the data layer.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      import NevernoteWeb.Router.Helpers

      # The default endpoint for testing
      @endpoint NevernoteWeb.Endpoint

      def log_in(user),
        do: log_in(Phoenix.ConnTest.build_conn(), user)

      def log_in(conn, user) do
        Nevernote.Guardian.Plug.sign_in(conn, user)
      end
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Nevernote.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Nevernote.Repo, {:shared, self()})
    end

    {:ok, user} =
      Nevernote.Accounts.create_user(%{
        email: "example@nevernote.com",
        username: "Example",
        password: "123456"
      })

    {:ok, conn: Phoenix.ConnTest.build_conn(), user: user}
  end
end
