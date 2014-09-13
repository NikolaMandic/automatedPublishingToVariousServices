defmodule Media.Github do
    use GenServer
    def init(_args) do
    	IO.puts "init github"
    	{:ok,[]}
    end
    def start_link(opts \\ [])do
    	 GenServer.start_link(__MODULE__, :ok, name: :github)
    end
    def handle_call(:post, _from, state)do
    	IO.puts "going to post to github"
	token = Application.get_env(:Github,:oauth2)[:access_token]
	header = %{"Authorization"=> "token " <> token}
	ret = HTTPoison.post "https://api.github.com/gists", JSEX.encode!(%{:description => "description",:public => true,:files => %{:file1 => %{:content => "file content"}}}),header
	dret = JSEX.decode! ret.body
	dret["html_url"]

    end
    def getPubUrl(post)do
        IO.puts "going to post to github"
	token = Application.get_env(:Github,:oauth2)[:access_token]
	header = %{"Authorization"=> "token " <> token}
	ret = HTTPoison.post "https://api.github.com/gists", JSEX.encode!(%{:description => post.description,:public => true,:files => %{:file1 => %{:content => File.read!("/tmp/"<>post.filename)}}}),header,timeout: 50000
	dret = JSEX.decode! ret.body
	dret["html_url"]
    end
end
