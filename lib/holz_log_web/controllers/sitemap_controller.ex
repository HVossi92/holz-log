defmodule HolzLogWeb.SitemapController do
  use HolzLogWeb, :controller

  alias HolzLog.Log

  # Replace with actual domain in production
  @domain_url "https://holzlog.example.com"

  def index(conn, _params) do
    notes = Log.list_notes(nil, nil)
    categories = Log.list_categories()

    sitemap_entries = [
      %{loc: "#{@domain_url}/", lastmod: Date.utc_today(), changefreq: "weekly", priority: "1.0"},
      %{
        loc: "#{@domain_url}/privacy",
        lastmod: Date.utc_today(),
        changefreq: "monthly",
        priority: "0.5"
      },
      %{
        loc: "#{@domain_url}/notes",
        lastmod: Date.utc_today(),
        changefreq: "daily",
        priority: "0.8"
      },
      %{
        loc: "#{@domain_url}/categories",
        lastmod: Date.utc_today(),
        changefreq: "weekly",
        priority: "0.7"
      }
    ]

    # Add all category pages
    category_entries =
      Enum.map(categories, fn category ->
        %{
          loc: "#{@domain_url}/notes?category_id=#{category.id}",
          lastmod: Date.utc_today(),
          changefreq: "weekly",
          priority: "0.6"
        }
      end)

    # Add all note detail pages
    note_entries =
      Enum.map(notes, fn note ->
        %{
          loc: "#{@domain_url}/notes/#{note.id}",
          lastmod: note.updated_at |> DateTime.to_date(),
          changefreq: "monthly",
          priority: "0.5"
        }
      end)

    all_entries = sitemap_entries ++ category_entries ++ note_entries

    conn
    |> put_resp_content_type("application/xml")
    |> render("sitemap.xml", entries: all_entries)
  end
end
