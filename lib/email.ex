defmodule Media.Email do
  use GenServer
  def __init__()do
    {:ok,[]}
  end
  def start_link(opts \\ [])do
      GenServer.start_link(__MODULE__, :ok, opts)
  end
end