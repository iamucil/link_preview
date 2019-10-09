defmodule LinkPreview.RestAPI do
  @moduledoc """
  LinkPreview.RestAPI restapi for link preview service
  """

  import Plug.Conn

  use Plug.Router
  require Logger
  plug Plug.Logger
  plug :match
  plug Plug.Parsers, parsers: [:json], json_decoder: Poison
  plug :dispatch

  def init(options) do
    options
  end

  get "/" do
    conn
    |> put_resp_content_type("application/json")
    |> resp(200, success("Welcome!"))
  end

  get "/healthz" do
    conn
    |> put_resp_content_type("application/json")
    |> resp(200, success("OK!"))
  end

  get "/meta" do
    {status, body} = case conn.query_params do
      %{"url" => url} ->
        case LinkPreview.Parser.parse(LinkPreview.Parser, url) do
          {:ok, body} -> {200, success(body)}
          {:error, reason} -> {502, error(reason)}
        end
      _ -> {400, error("Invalid request")}

    end
    conn
    |> put_resp_content_type("application/json")
    |> resp(status, body)
  end

  match _ do
    conn
    |> put_resp_content_type("application/json")
    |> resp(400, error("Oops..!"))
  end

  defp success(data) do
      Poison.encode!(%{result: data})
  end

  defp error(msg) do
      Poison.encode!(%{error: msg})
  end
end
