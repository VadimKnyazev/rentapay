defmodule FTPWatcher do
  def work do
    :inets.start
    {:ok, pid} = connect('static.rentapay.ru')
    pid |> auth("webroot", "ZSAmwpB0mU") |> list_files
  end
  def connect(server), do: :inets.start(:ftpc, host: server)
  def auth(pid, login, password), do: :ftp.user(pid, login, password)
  def list_files(pid), do: :ftp.pwd(pid) |> IO.inspect
end

FTPWatcher.work
