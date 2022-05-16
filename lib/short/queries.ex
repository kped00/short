defmodule Short.Queries do
  import Ecto.Query
  require Logger

  def fetch_url(customurl) do
    result = Short.Repo.all(from l in Short.Link, where: l.customurl == ^customurl, select: l.url)
    case result do
      [] -> {:error, :notfound}
      [x] -> {:ok, x}
      err -> 
        Logger.debug err
        {:error, "wtf"}

    end
  end

  def add_url(customurl, url, owner) do
    if fetch_url(customurl) == {:error, :notfound} do
      changeset = Short.Link.changeset(%Short.Link{}, %{customurl: customurl, url: url, owner: owner})
      case changeset.valid? do
        true -> Short.Repo.insert(changeset)
        false -> {:error, changeset.errors}
      end
    else
        {:error, [customurl: {"already taken", "help me"}]}
    end
  end

  def add_url(customurl, url) do
    add_url(customurl, url, "Anonymous")
  end
end
