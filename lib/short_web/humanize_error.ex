defmodule ShortWeb.HumanizeError do
  def add_err(err) do
    out = ""
    out = if err[:url] != nil do
      out <> "\nurl " <> elem(err[:url], 0)
    else
      out
    end
    out = if err[:customurl] != nil do
      out <> "\ncustomurl " <> elem(err[:customurl], 0)
    else
      out
    end
    out
  end
end
