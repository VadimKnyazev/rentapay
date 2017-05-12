defmodule Rentapay.Middleware do
  defmodule Before do
    use Maru.Middleware

    def call(conn, opts) do
      IO.inspect conn
      IO.inspect opts
      IO.puts "BEFORE"
      conn
    end
  end

  defmodule After do
    use Maru.Middleware

    def call(conn, opts) do
      IO.inspect conn.resp_body
      IO.inspect opts
      #result = conn()
      #result
      conn |> text("ff")
    end
  end
end
