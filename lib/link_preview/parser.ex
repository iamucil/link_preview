defmodule LinkPreview.Parser do
  @moduledoc false

  use GenServer, restart: :transient
  require Logger
  require OpenGraph

  @doc false
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @doc false
  def init(:ok), do: {:ok, %{}}

  def parse(pid, url) do
    GenServer.call(pid, {:parse, url})
  end

  def handle_call({:parse, url}, _from, pid) do
    # meta =
    #   case OpenGraph.fetch(url) do
    #     {:ok, data} ->
    #       data

    #     {:error, _} ->
    #       OpenGraphData.__struct__()
    #       |> Map.put(:title, "Build software better, together")
    #       |> Map.put(:url, 'https://github.com')
    #       |> Map.put(
    #         :image,
    #         'https://assets-cdn.github.com/images/modules/open_graph/github-logo.png'
    #       )
    #       |> Map.put(
    #         :description,
    #         "GitHub is where people build software. More than 28 million people use GitHub to discover, fork, and contribute to over 85 million projects."
    #       )
    #   end

    {:reply, OpenGraph.fetch(url), pid}
  end

  def handle_info(:pid, state) do
    {:noreply, state}
  end
end
