defmodule Media.Flikr do
    use GenServer
    def init(_args) do
    	{:ok,[]}
    end
    def start_link(opts \\ [])do
    	 GenServer.start_link(__MODULE__, :ok, name: :flikr)
    end
end