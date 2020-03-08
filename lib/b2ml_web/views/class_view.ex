defmodule B2mlWeb.ClassView do
  use B2mlWeb, :view
  import B2mlWeb.Gettext

  def custom_datetime_select(form, field, [locale: locale] = opts \\ []) do
    opts =
      locale
      |> custom_datetime_builder()
      |> custom_datetime_opts(opts)

    datetime_select(form, field, opts)
  end

  def is_class_open(open_date, close_date) do
    current_date = DateTime.utc_now()
    is_after_open =
      DateTime.compare(open_date, current_date) == :lt
      || DateTime.compare(open_date, current_date) == :eq
    is_before_close =
      DateTime.compare(current_date, close_date) == :lt
      || DateTime.compare(current_date, close_date) == :eq

    cond do
        is_after_open == true && is_before_close == true ->
          gettext("Opened")

        true ->
          gettext("Closed")
    end
  end

  def teacher_select_options(teachers) do
    for teacher <- teachers, do: {teacher.name, teacher.id}
  end

  defp custom_datetime_builder(locale) do
    case locale do
      "en" ->
        fn b ->
          ~e"""
          Date: <%= b.(:year, []) %> / <%= b.(:month, []) %> / <%= b.(:day, []) %>
          Time: <%= b.(:hour, []) %> : <%= b.(:minute, []) %>
          """
        end

      _ ->
        fn b ->
          ~e"""
          Date: <%= b.(:day, []) %> / <%= b.(:month, []) %> / <%= b.(:year, []) %>
          Time: <%= b.(:hour, []) %> : <%= b.(:minute, []) %>
          """
        end
    end
  end

  defp custom_datetime_opts(builder, opts) do
    opts
    |> Keyword.put(:builder, builder)
    |> Keyword.put(:default, DateTime.utc_now())
    |> Keyword.put(:year, [options: 1900..2100])
    |> Keyword.put(:month, [
      options: [
        {gettext("January"), "1"},
        {gettext("February"), "2"},
        {gettext("March"), "3"},
        {gettext("April"), "4"},
        {gettext("May"), "5"},
        {gettext("June"), "6"},
        {gettext("July"), "7"},
        {gettext("August"), "8"},
        {gettext("September"), "9"},
        {gettext("October"), "10"},
        {gettext("November"), "11"},
        {gettext("December"), "12"}
      ]
    ])
  end
end
