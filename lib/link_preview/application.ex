defmodule LinkPreview.Application do
  @moduledoc """
  LinkPreview.Application Entry point for link preview web server
  """

  use Application 
  require Logger 

  def start(_type, _args) do
    childrens = [
      {LinkPreview.Parser, name: LinkPreview.Parser},
      {Plug.Cowboy, scheme: :http, plug: LinkPreview.RestAPI, options: [port: 8080]}
    ]

    opts = [strategy: :one_for_one, name: LinkPreview.Supervisor]

    Logger.info("Starting application...")
    Supervisor.start_link(childrens, opts)
  end
end
