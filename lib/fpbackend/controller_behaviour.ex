defmodule FpbackendWeb.Controller do
  @callback service() :: atom
  @callback many_key() :: atom
  @callback one_key() :: atom
end
