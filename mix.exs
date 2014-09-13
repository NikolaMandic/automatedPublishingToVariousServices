defmodule Bot.Mixfile do
  use Mix.Project

  def project do
    [app: :bot,
     version: "0.0.1",
     elixir: "~> 1.1.0-dev",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger,:cowboy, :oauth2ex, :inets, :ssl,:hackney, :crypto ,:extwitter, :httpoison,:crypto, :cowlib, :ranch, :hello_world],
     mod: {Bot, [applications: [:logger]]}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [ {:oauth2ex, [git: "https://github.com/parroty/oauth2ex.git"]},
      {:extwitter, [git: "https://github.com/parroty/extwitter"]},
      {:oauth, nil, [git: "git://github.com/tim/erlang-oauth.git"]},
      {:httpoison, "~> 0.4"},
      {:dropbox, [git: "https://github.com/ammmir/elixir-dropbox"]},
      {:erlcloud, [git: "https://github.com/gleber/erlcloud"]},
      {:hackney, nil, [git: "https://github.com/benoitc/hackney.git",ref: "master",override: true]},
      {:jsx, ~r/.*/, [git: "https://github.com/talentdeficit/jsx.git", override: true]},
      {:gen_smtp,[git: "https://github.com/Vagabond/gen_smtp.git"]},
      {:cowboy, ~r/.*/, [git: "git://github.com/extend/cowboy.git", ref: "master",override: true]},
      {:hello_world ,[git: "https://github.com/m-2k/cowboy-multipart-upload-example.git"]}
    ]
  end
end
