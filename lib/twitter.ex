defmodule Media.Twitter do
  use GenServer
  def init(_args)do
  ExTwitter.configure(
   consumer_key: Application.get_env(:Twitter,:oauth1)[:consumer_key],
   consumer_secret: Application.get_env(:Twitter,:oauth1)[:consumer_secret],
   access_token: Application.get_env(:Twitter,:oauth1)[:access_token],
   access_token_secret: Application.get_env(:Twitter,:oauth1)[:access_token_secret]
   )
   IO.puts "init twitter"
    {:ok,[]}
  end
  def start_link(opts \\ [])do
       GenServer.start_link(__MODULE__, :ok, name: :Twitter)
  end
  def handle_call({:post,content,links},_from,_)do
      IO.puts "Twitter about to update"
      #ExTwitter.update(content.title <> "\n" <>links.thingiverse <>" "<>links.github
      #<> " " <> links.picture <>" "<>links.video)
      ExTwitter.update(
	content.title <>
 	"\n#3dprinting #3Dprint\n"<>
      Enum.join(links, " \n"))
      IO.puts "updated Twitter"
      {:reply,1,[]}
  end
end
