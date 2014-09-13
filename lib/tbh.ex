defmodule TPH do

  def init(_t,r,[])do
    {:ok,r,:undefined}
  end
  def handle(req,state)do
    body = ~S"""
        <form action="/upload" method="post" enctype="multipart/form-data">
            title:
            <br/>
            <input name="title" type="text" /><br/>
            category:
            <br/>
            <input name="category" type="text" /><br/>
            tags:
            <br/>
            <input name="tags" type="text" /><br/>
            description:<br/>
            <textarea name="description" rows=6 cols=30></textarea><br/>
            links: <br/>
            <textarea name="links" rows=6 cols=30></textarea><br/>
            image1: <br/>

            <input name="image1" type="file" /><br/>
            image2: <br/>

            <input name="image2" type="file" /><br/>
            image3: <br/>

            <input name="image3" type="file" /><br/>
            video1: <br/>

            <input name="video1" type="file" /><br/>
            video2: <br/>

            <input name="video2" type="file" /><br/>
            <input value="publish" type="submit" />
        </form>


    """
    {:ok,req2}=:cowboy_req.reply(200,[],body,req)
    {:ok,req2,state}
  end
  def terminate(_reason,_req,_state)do
    :ok
  end
end
