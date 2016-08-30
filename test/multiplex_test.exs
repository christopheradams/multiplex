defmodule MultiplexTest do
  use ExUnit.Case
  use Plug.Test

  defmodule FooController do
    use Phoenix.Controller

    def index(conn, _) do
      send_resp(conn, 200, "#{conn.method} foo")
    end
  end

  defmodule MultiplexRouter do
    use Multiplex

    mux [:get, :post], "/foo", FooController, :index
  end

  test "GET /foo" do
    conn = conn(:get, "/foo")
    |> MultiplexRouter.call([])

    assert conn.status == 200
    assert conn.resp_body == "GET foo"
  end

  test "POST /foo" do
    conn = conn(:post, "/foo")
    |> MultiplexRouter.call([])

    assert conn.status == 200
    assert conn.resp_body == "POST foo"
  end
end
