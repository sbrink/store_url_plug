defmodule StoreUrlPlug do
  @moduledoc """
  Saves the current url to help redirecting back if the user just logged in.
  It should not be included in any auth page to prevent a redirect loop.
  """
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    request_url = Plug.Conn.request_url(conn)

    conn
    |> fetch_session()
    |> put_session(:last_visited_url, request_url)
  end

  def get_stored_url(%Plug.Conn{} = conn) do
    get_session(conn, :last_visited_url)
  end
end
