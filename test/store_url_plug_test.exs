defmodule StoreUrlPlugTest do
  use ExUnit.Case
  use Plug.Test

  describe "#init" do
    test "returns the same as input" do
      assert StoreUrlPlug.init("hello") == "hello"
    end
  end

  describe "#call" do
    test "saves the current url in the session" do
      result_conn =
        conn(:get, "/visited_url")
        |> init_test_session(%{})
        |> StoreUrlPlug.call(nil)

      assert get_session(result_conn, :last_visited_url) == "http://www.example.com/visited_url"
    end
  end

  describe "#get_stored_url" do
    test "retrieves the last visited url from the session if available" do
      result_conn =
        conn(:get, "/login")
        |> Plug.Test.init_test_session(%{last_visited_url: "http://example.com/test"})

      assert StoreUrlPlug.get_stored_url(result_conn) == "http://example.com/test"
    end
  end
end
