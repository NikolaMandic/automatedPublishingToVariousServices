defmodule Media.Email do
  use GenServer


  def init(_args)do
      IO.puts "init mail"
    {:ok,[]}
  end
  def start_link(opts \\ [])do
      GenServer.start_link(__MODULE__, :ok, name: :email)
  end
  def handle_call({:post,content,links},_from,_)do
      IO.puts "about to update mail"
      r=:gen_smtp_client.send_blocking({"nikola@nikola.link", ["mn080202@gmail.com"], "Subject: subject\r\nFrom: nikola@nikola.link \r\nTo: mn080202@gmail.com \r\n\r\n " <> "just posted "<> content.title <>" "<>"\nbrief description:\n" <> content.description <> "\n" <> Enum.join(links,"\n")},  [{:relay, "localhost"},{:ssl, false},{:tls, :never},{:port, 25},{:auth, :never}])
      IO.puts r
      IO.puts "mail update finish"
      {:reply,1,[]}
  end
end
