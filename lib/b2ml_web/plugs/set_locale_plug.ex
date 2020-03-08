defmodule B2mlWeb.Plugs.SetLocale do
  import Plug.Conn

  @supported_locales Gettext.known_locales(B2mlWeb.Gettext)

  def init(_opts), do: nil

  def call(conn, _opts) do
    locale = conn.params["locale"] || conn.cookies["locale"]

    cond do
      locale in @supported_locales ->
        B2mlWeb.Gettext
        |> Gettext.put_locale(locale)

        conn
        |> put_resp_cookie("locale", locale, max_age: 365 * 24 * 60 * 60)

      true ->
        conn
    end
  end
end
