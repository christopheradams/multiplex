defmodule Multiplex do
  @moduledoc """
  Phoenix router macro to dispatch multiple HTTP methods to a Plug

  It provides a `mux` macro that generates a Phoenix route for each
  verb.

  Edit `web/web.ex` and add the module:

      def router do
        quote do
          use Phoenix.Router
          use Multiplex
        end
      end

  Then use the `mux` macro in your router to match one or more
  HTTP verbs with a Controller:

      defmodule MyApp.Router do
        use HelloPhoenix.Web, :router

        mux [:get, :post], "/pages", PageController, :index
      end
  """

  @doc false
  defmacro __using__(_) do
    quote location: :keep do
      use Phoenix.Router
      import Multiplex

      unquote(defs())
    end
  end

  # Define a function that will be used by the mux macro to
  # generate a match for every method.
  @spec defs() :: Macro.t
  defp defs() do
    quote do
      var!(add_match, Multiplex) = fn (verbs, path, plug, plug_opts, options) ->
        for verb <- verbs do
          match verb, path, plug, plug_opts, options
        end
      end
    end
  end

  @doc """
  Main API to define multiple HTTP verbs for a route.

  It accepts a list of HTTP methods as atoms, a path, a Plug, and its
  options.

  ## Examples

       mux [:get, :post], "/pages/:page", PageController, :show
  """
  @spec mux([atom], String.t, atom, any, any) :: Macro.t
  defmacro mux(verbs, path, plug, plug_opts, options \\ []) do
    add_mux(verbs, path, plug, plug_opts, options)
  end

  @spec add_mux([atom], String.t, atom, any, any) :: Macro.t
  defp add_mux(verbs, path, plug, plug_opts, options) do
    quote bind_quoted: [verbs: verbs, path: path, plug: plug,
                        plug_opts: plug_opts, options: options] do
      var!(add_match, Multiplex).(verbs, path, plug, plug_opts, options)
    end
  end
end
