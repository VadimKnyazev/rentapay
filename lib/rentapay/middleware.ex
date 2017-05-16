defmodule Rentapay.Middleware do
  defmodule JWT do
    use Maru.Middleware
    def call(conn, _opts) do
      jwt_payload = get_req_header(conn, "authorization") |> token_from_header
      conn
      |> assign(:current_user, jwt_payload)
      |> put_private(:current_user, jwt_payload)
      #IO.inspect(conn.private)
      #conn
    end

    defp token_from_header([]), do: nil
    defp token_from_header(["Bearer " <> token]) do
      {:ok, payload} = token |> Rentapay.Token.validate
      payload
    end
  end
end
