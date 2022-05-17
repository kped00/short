defmodule Short.Link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :customurl, :string
    field :owner, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:owner, :customurl, :url])
    |> validate_required([:customurl, :url])
    |> validate_format(:url, ~r/^https?:\/\//, message: "needs to be a http(s) url")
    |> validate_format(:customurl, ~r/^[a-zA-Z0-9_\-]+$/, message: "cannot use characters other than alphanumeric, underscores, and dashes")
  end
end
