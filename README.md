# Holz Log

This is a simple micro-blog built with the Phoenix Framework and inspired by Joplin's note-taking organization. The goal is to provide a straightforward way to create, categorize, and share notes publicly.

## Features

- **Note Creation**: A "Create Note" button at the top opens a form to create new notes. Uses a simple text area for content, allowing Markdown.
- **Note Editing**: Each note displayed has an "Edit" button that opens a form to modify the note.
- **Categories (Notebooks)**: Notes can be assigned to multiple categories.
- **Category Sidebar**: A sidebar displays a list of categories/notebooks. Clicking a category filters the notes to only show those in that category. Clicking "All Notes" shows all notes.
- **Search**: A search bar allows users to find notes by title or content.
- **Markdown Support**: Note content is interpreted as Markdown for formatted display.
- **SQLite Database**: Uses SQLite for easy setup and deployment.
- **Tailwind CSS**: Styled with Tailwind CSS for a clean and responsive design.

## Layout

The website consists of the following main sections:

### Header

- Contains the site title/logo (if any)
- "Create Note" button
- Search bar

### Sidebar (Left)

- A list of all categories/notebooks
- Each category is a clickable link
- An "All Notes" link to display all notes regardless of category

### Main Content Area (Right)

- Displays a list of notes
- Each note shows:
  - Title (clickable link to view the full note)
  - Short excerpt of the content (e.g., the first 100-200 characters)
  - The categories/notebooks the note is assigned to
  - An "Edit" button to open the edit form for that note

### Single Note View

- Displays the full content of a single note
- Shows the title and categories
- An "Edit" button to edit the note
- A "Back" button to return to the main notes list (or the category listing)

## Tailwind CSS Styling

The site uses Tailwind CSS utility classes extensively. Here's a general overview of the styling approach:

- **Readability**: Focus on clear typography, good line height, and sufficient padding/margin
- **Color Palette**: Primarily light backgrounds, with a muted accent color for links, headings, and highlighting. Dark mode is not implemented in this iteration
- **Responsive Design**: Uses Tailwind's responsive prefixes (e.g., `md:`, `lg:`) to adjust the layout for different screen sizes. The sidebar typically collapses to a top navigation bar on smaller screens

## Database Schema (SQLite)

The SQLite database consists of two main tables:

### notes

```sql
CREATE TABLE notes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    inserted_at DATETIME,
    updated_at DATETIME
);
```

### categories

```sql
CREATE TABLE categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);
```

### note_categories (Join Table)

```sql
CREATE TABLE note_categories (
    note_id INTEGER REFERENCES notes(id),
    category_id INTEGER REFERENCES categories(id),
    PRIMARY KEY (note_id, category_id)
);
```

## Technologies Used

- **Phoenix Framework**: The web framework
- **Ecto**: Database abstraction layer
- **SQLite**: Database
- **Tailwind CSS**: CSS framework
- **Earmark**: Markdown parser

## Setup Instructions

1. Install Elixir and Erlang:

   - Follow the instructions on the [Elixir website](https://elixir-lang.org/install.html)

2. Install Phoenix:

   ```bash
   mix archive.install hex phx_new
   ```

3. Create a new Phoenix project:

   ```bash
   mix phx.new my_microblog --no-html --no-webpack --no-dashboard
   cd my_microblog
   ```

   - `--no-html` prevents the generation of the default HTML layouts (we'll use Tailwind instead)
   - `--no-webpack` skips the default webpack configuration since we'll use the simpler esbuild
   - `--no-dashboard` omits the Erlang Observer dashboard

4. Install esbuild:
   Add esbuild as a dependency in `mix.exs` and run `mix deps.get`:

   ```elixir
   defp deps do
     [
       {:phoenix, "~> 1.7.0"},
       {:ecto_sqlite3, "~> 0.2"},
       {:ecto_sql, "~> 3.0"},
       {:esbuild, "~> 0.8", runtime: Mix.env() == :dev},
       {:earmark, "~> 1.4"}
     ]
   end
   ```
