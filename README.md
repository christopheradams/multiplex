# Multiplex

![tickets](/priv/static/tickets.png)

[![Build Status](https://travis-ci.org/christopheradams/multiplex.svg?branch=master)](https://travis-ci.org/christopheradams/multiplex)
[![Hex Version](https://img.shields.io/hexpm/v/multiplex.svg)](https://hex.pm/packages/multiplex)

Phoenix router macro to dispatch multiple HTTP methods to a Plug

The package adds a `mux` macro to your router to match one or more
HTTP verbs with a Controller (or any Plug):

```elixir
defmodule MyApp.Router do
  use HelloPhoenix.Web, :router

  mux [:get, :post], "/pages", PageController, :index
end
```

## Installation

Add Multiplex to your Phoenix project in two steps:

  1. Add `:multiplex` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:multiplex, "~> 0.1.0"}]
    end
    ```

  2. Edit `web/web.ex` and add the module:

    ```elixir
    def router do
      quote do
        use Phoenix.Router
        use Multiplex
      end
    end
    ```

## License

Multiplex copyright &copy; 2016, [Christopher Adams](https://github.com/christopheradams)

tickets CC-by Arthur Lacôte from the Noun Project
