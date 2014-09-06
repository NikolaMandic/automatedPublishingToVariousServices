defmodule Media.Thingiverse do
    use GenServer
    def init(_args) do
    	accessToken = Application.get_env(:Thingiverse, :oauth2)[:access_token]
    	{:ok,%{"Authorization"=> "Bearer " <> accessToken}}
    end
    def start_link(opts \\ [])do
    	 GenServer.start_link(__MODULE__, :ok, opts)
    end
    def getToken(state)do
    	token=HTTPoison.post("https://thingiverse.com/login/oauth/access_token", :hackney_url.qs([client_id: "0eb38488b76632671e6a",client_secret: "6429f9665b27e8049c14d594bc98de0e", code: "0d4dbbb860d919eedaeadc7387329ca8"]),  %{"Content-type"=> "application/x-www-form-urlencoded"}, [])
    	url="https://api.thingiverse.com/users/me"
    	HTTPoison.get(url,  state, [])
    end
    def uploadThing()do
    end
end