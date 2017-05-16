import Joken
alias Rentapay.Entity, as: DB
defmodule Rentapay.Token do
  def generate(%DB.User{id: user_id, login: email}) do
    %{id: user_id, email: email}
    |> token
    |> with_validation("user_id", fn(id) -> id == user_id end)
    |> with_signer(hs256(secret))
    |> sign
    |> get_compact
  end

  def validate(access_token) do
    access_token
    |> token
    |> with_signer(hs256(secret))
    |> verify!
  end

  defp secret do
    "593BE17D9D6164EBA9F50AE1A5099A4AEF2842DE68F40AA59DB1ADDC8BBDEE9079C9A4B9B6B9BF5A914CAB2D78D69CBFE5D18435E4016DC203DD0561B5AA4429"
  end
end
