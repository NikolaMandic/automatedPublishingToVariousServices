defmodule Media.Google do
    use GenServer
    def init(_args) do

    	{:ok,[]}
    end
    def start_link(opts \\ [])do
    	 GenServer.start_link(__MODULE__, :ok, opts)
    end
    def google()do
        # Setup config parameters (retrive required parameters from OAuth 2.0 providers).
    config = OAuth2Ex.config(
    id:            System.get_env("GOOGLE_API_CLIENT_ID"),
    secret:        System.get_env("GOOGLE_API_CLIENT_SECRET"),
    authorize_url: "https://accounts.google.com/o/oauth2/auth",
    token_url:     "https://accounts.google.com/o/oauth2/token",
    scope:         "https://www.googleapis.com/auth/bigquery",
    callback_url:  "http://localhost:4000",
    token_store:   %OAuth2Ex.FileStorage{
    file_path: System.user_home <> "/oauth2ex.google.token"}
    )
    # -> %OAuth2Ex.Config{authorize_url: "https://accounts.google.com/o/oauth2/auth"...

    # Retrieve token from server. It opens authorize_url using browser,
    # and then waits for the callback on the local server on port 4000.
    token = OAuth2Ex.Token.browse_and_retrieve!(config, receiver_port: 4000)
    # -> %OAuth2Ex.Token{access_token: "..."

    # Access API server using token.
    response = OAuth2Ex.HTTP.get(token, "https://www.googleapis.com/bigquery/v2/projects")
    # -> %HTTPoison.Response{body: "{\n \"kind\": \"bigquery#projectList...
 
    end
end