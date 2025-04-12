defmodule HolzLogWeb.PageController do
  use HolzLogWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    conn
    |> assign(:page_title, "Home")
    |> assign(
      :meta_description,
      "Holz Log - A simple, elegant app for managing your notes and logs"
    )
    |> assign(:meta_keywords, "notes app, log management, note organization, holz log")
    |> assign(:canonical_url, url(~p"/"))
    |> render(:home, layout: false)
  end

  def privacy(conn, _params) do
    conn
    |> assign(:page_title, "Privacy Policy")
    |> assign(
      :meta_description,
      "Privacy Policy for Holz Log - Learn how we protect your data and privacy"
    )
    |> assign(:meta_keywords, "privacy policy, data protection, holz log privacy")
    |> assign(:canonical_url, url(~p"/privacy"))
    |> render(:privacy)
  end

  def robots(conn, _params) do
    conn
    |> put_resp_content_type("text/plain")
    |> render(:robots)
  end
end
