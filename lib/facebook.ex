defmodule Media.Facebook do
    use GenServer
    def init(_args) do
    	{:ok,[]}
    end
    def start_link(opts \\ [])do
       GenServer.start_link(__MODULE__, :ok, opts)
    end
end