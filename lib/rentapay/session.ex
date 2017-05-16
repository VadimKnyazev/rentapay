defmodule Rentapay.Session do
  def current_user(conn) do
    conn.private.current_user
  end

end
