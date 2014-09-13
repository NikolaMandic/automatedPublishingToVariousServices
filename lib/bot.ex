defmodule Bot do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      worker(Media.Box, []),
      worker(Media.Youtube, []),
      worker(Media.Google, []),
      worker(Media.Website, []),
      worker(Media.Twitter, []),
      worker(Media.Grabcad, []),
      worker(Media.Thingiverse, [[name: :thingiverse]]),
      worker(Media.Dropbox, []),
      worker(Media.Flikr, []),
      worker(Media.Instagram, []),
      worker(Media.Facebook, []),
      worker(Media.Tumblr, []),
      worker(Media.Email, []),
      worker(Media.S3, [])
    ]
    IO.puts "asdasd"

    Application.get_env(:kv, :routing_table)
    config = OAuth2Ex.config(
    id:            "Gsc0uljWu0x4XLgjtsDbFbhXI",
    secret:        "75To5VbV06HF97AAQGBtHdelsyCOl6ZExNnQkEWUlMxOfh6vz5",
    authorize_url: " https://api.twitter.com/oauth/authorize",
    token_url:     "https://api.twitter.com/oauth/request_token",
    #scope:         "https://www.googleapis.com/auth/bigquery",
    callback_url:  "urn:ietf:wg:oauth:2.0:oob",
    token_store:   %OAuth2Ex.FileStorage{
    file_path: System.user_home <> "/oauth2ex.google.token"}
    )

#IO.puts OAuth2Ex.get_authorize_url(config)
    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Bot.Supervisor]
    Supervisor.start_link(children, opts)
  end
  def postStuff(post) do
      #GenServer.call(:thingiverse, :post)
      turl = Media.Thingiverse.getToken(post)
      pubUrl = Media.Github.getPubUrl(post)
#      links=%Links{thingiverse: turl, github: pubUrl}
      links = [turl,pubUrl] 
	#++ ["http://instagram.com/mn080202","gitstash repo \"uControllerBot3dPrinting\""]

      GenServer.call :email,{:post, post,links}
      GenServer.call :Twitter,{:post, post,links}
  end
end
