defmodule HexpmWeb.BlogView do
  use HexpmWeb, :view

  alias Hexpm.Utils

  skip_slugs = ~w()

  all_templates =
    Phoenix.Template.find_all(@phoenix_root)
    |> Enum.map(&Phoenix.Template.template_path_to_name(&1, @phoenix_root))
    |> Enum.flat_map(fn
      <<n1, n2, n3, "-", slug::binary>> = template
      when n1 in ?0..?9 and n2 in ?0..?9 and n3 in ?0..?9 ->
        [{Path.rootname(slug), template}]

      _other ->
        []
    end)
    |> Enum.reject(fn {slug, _template} -> slug in skip_slugs end)
    |> Enum.sort_by(&elem(&1, 1), &>=/2)

  def render("index.html", _assigns) do
    [first_post | posts] = posts()
    render_template("index.html", first_post: first_post, posts: posts)
  end

  def render("index.xml", _assigns) do
    render_template("index.xml", posts: posts())
  end

  def render(other, assigns) do
    content_tag(:div, render_template(other, assigns), class: "show-post")
  end

  def all_templates() do
    unquote(all_templates)
  end

  def post_date(post) do
    Enum.at(post_subtitle(post), 0)
  end

  def post_author(post) do
    Enum.at(post_subtitle(post), 1)
  end

  defp post_subtitle(post) do
    String.split(post.subtitle, "by")
  end

  def post(slug) do
    case List.keyfind(all_templates(), slug, 0) do
      {_slug, template} -> post_meta(slug, template)
      nil -> nil
    end
  end

  def posts() do
    Enum.map(all_templates(), fn {slug, template} -> post_meta(slug, template) end)
  end

  defp post_meta(slug, template) do
    content = render(template, %{})
    content = Phoenix.HTML.safe_to_string(content)

    %{
      slug: slug,
      template: template,
      title: title(content),
      subtitle: subtitle(content),
      paragraph: first_paragraph(content),
      published: published(content)
    }
  end

  defp first_paragraph(content) do
    regex_run(~r[<p>(.*)</p>]sU, content)
  end

  defp title(content) do
    regex_run(~r[<h2>(.*)</h2>]sU, content)
  end

  defp subtitle(content) do
    regex_run(~r[<div class="subtitle">(.*)</div>]sU, content)
  end

  defp published(content) do
    {:ok, datetime, _utc_offset} =
      ~r[<time datetime="(.+)">(.+)</time>]sU
      |> regex_run(content)
      |> DateTime.from_iso8601()

    Utils.datetime_to_rfc2822(datetime)
  end

  defp regex_run(regex, string) do
    regex
    |> Regex.run(string)
    |> Enum.at(1)
    |> String.trim()
  end
end
