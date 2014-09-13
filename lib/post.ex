defmodule Media.Post do
  defstruct title: "default",
  	    description: "default description",
	    category: "category",
	    tags: "tags",
	    filename: "filename",
	    file: "file",
	    picture: "",
	    picture2: "",
	    video: "",
	    video2: "",
	    links: ""   
end
defmodule Links do
  defstruct thingiverse: "",
  	    github: "",
	    instagram: ""
end
