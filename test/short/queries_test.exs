defmodule Short.QueriesTest do
  use Short.DataCase, async: true

  test "queries and adds entries" do
    assert Short.Queries.fetch_url("test") == {:error, :notfound}

    assert elem(elem(Short.Queries.add_url("test", "potato", "test"), 1)[:url], 0) == "needs to be a http(s) url"

    assert elem(Short.Queries.add_url("test", "https://hex.pm/", "test"), 0) != :error

    assert Short.Queries.fetch_url("test") == {:ok, "https://hex.pm/"}
  end
end
