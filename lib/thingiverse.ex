defmodule Media.Thingiverse do
    use GenServer
    def init(_args) do
    	IO.puts "about to start thingiverse"
    	accessToken = Application.get_env(:Thingiverse, :oauth2)[:access_token]
    	{:ok,%{"Authorization"=> "Bearer " <> accessToken}}
    end
    def start_link(opts \\ [])do
    	 GenServer.start_link(__MODULE__, :ok, name: :thingiverse)
    end

    def handle_call(:post, _from, state) do
    	IO.puts "going to post to thingiverse"
    	getToken(:state)
    	{:reply, :creply, []}
    end
    def getToken(state)do
    	IO.puts "about to send to thingiverse"
    	client_id = Application.get_env(:Thingiverse, :oauth2)[:client_id]
	client_secret = Application.get_env(:Thingiverse, :oauth2)[:client_secret]
	code = Application.get_env(:Thingiverse, :oauth2)[:code]
	access_token = Application.get_env(:Thingiverse, :oauth2)[:access_token]
	header = %{"Authorization"=> "Bearer " <> access_token}
#	IO.puts HTTPoison.get("https://api.thingiverse.com/users/me",  header, []).body
    	#url="https://api.thingiverse.com/users/me"
	reply=HTTPoison.post "https://api.thingiverse.com/things",(JSEX.encode! %{"name" => state.filename, "category" => state.category,"tags"=>String.split(state.tags),"description"=> state.description,"instructions"=> "asd","is_wip"=>true,"licence"=>"cc"}),header
	IO.puts "reply on creation"
	IO.puts reply.body
	rr=JSEX.decode! reply.body
	frep=HTTPoison.post("https://api.thingiverse.com/things/"<>Integer.to_string(rr["id"])<>"/files",JSEX.encode!(%{"filename" => state.filename}),header)
	frepD = JSEX.decode! frep.body
	IO.puts frep.body
	#HTTPoison.post "http://requestb.in/103a28b1",JSEX.encode! %{"filename" => state.filename}

	h=:hackney.request(:post,
                 "https://thingiverse-production.s3.amazonaws.com",
                 [],
                 {:multipart, [{"AWSAccessKeyId",
                                frepD["fields"]["AWSAccessKeyId"], 
                                {"form-data", [{"name", "AWSAccessKeyId"}]}, []},
                               {"bucket",
                                frepD["fields"]["bucket"], 
                                {"form-data", [{"name", "bucket"}]}, []},
                               {"key",
                                frepD["fields"]["key"], 
                                {"form-data", [{"name", "key"}]}, []},
                               {"acl",
                                frepD["fields"]["acl"], 
                                {"form-data", [{"name", "acl"}]}, []},
                               {"success_action_redirect",
                                frepD["fields"]["success_action_redirect"], 
                                {"form-data", [{"name", "success_action_redirect"}]}, []},
                               {"policy",
                                frepD["fields"]["policy"], 
                                {"form-data", [{"name", "policy"}]}, []},
                               {"signature",
                                frepD["fields"]["signature"], 
                                {"form-data", [{"name", "signature"}]}, []},
                               {"Content-Type",
                                frepD["fields"]["Content-Type"], 
                                {"form-data", [{"name", "Content-Type"}]}, []},
                               {"Content-Disposition",
                                frepD["fields"]["Content-Disposition"], 
                                {"form-data", [{"name", "Content-Disposition"}]}, []},
                               {:file, 
                                state.file, 
                                {"form-data", [{"name", "file"},{"filename", state.filename}]}, 
                                [{"Content-Transfer-Encoding", "binary"}]}]})
		{:ok,resp,_,_}=h
		IO.puts Integer.to_string resp
		lastR=HTTPoison.post(frepD["fields"]["success_action_redirect"],"",header)
		IO.puts lastR.body
		IO.puts "upload to thingiverse finished"
		a=HTTPoison.post("https://api.thingiverse.com/things/"<>Integer.to_string(rr["id"])<>"/publish","",header)
		IO.puts "result"
		IO.puts a.body
		jsxr=JSEX.decode! a.body
		jsxr["public_url"]
    		#HTTPoison.get(url,  state, [])
    end
    def uploadThing()do
    end
end
