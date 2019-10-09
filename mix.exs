defmodule LinkPreview.MixProject do
  use Mix.Project
  @version "0.1.0"

  def project do
    [
      app: :link_preview,
      version: @version,
      description: description(),
      docs: docs(),
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      build_embeded: Mix.env() == :prod,
      deps: deps(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: applications(Mix.env()),
      extra_applications: [:logger],
      mod: {LinkPreview.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.1"},
      {:poison, "~> 4.0"},
      # {:opengraph, "~> 0.1.0"},
      {:open_graph, "~> 0.0.4"},
      {:remix, "~> 0.0.2", only: :dev},
      {:ex_doc, "~> 0.21.2", only: :dev}
    ]
  end

  defp applications(:dev), do: applications(:all) ++ [:remix]

  defp applications(_all) do
    [
      :plug_cowboy,
      :open_graph
    ]
  end

  defp docs do
    [extras: doc_extras(), main: "readme"]
  end

  defp doc_extras do
    ["README.md"]
  end

  defp description do
    """
    Link preview
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README", "LICENSE"],
      maintainers: ["iamucil"],
      licenses: ["GNU"],
      links: %{
        "Github" => "https://github.com/iamucil/link_preview.git"
      }
    ]
  end
end
