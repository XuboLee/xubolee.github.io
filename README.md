# Xubo's Homepage

Personal academic homepage built with Jekyll and based on the `academicpages` template.

## Daily Maintenance

Most updates only require editing one file category:

- Home page intro and news: `_pages/about.md`
- Sidebar profile, avatar, links, email, GitHub, Google Scholar: `_config.yml`
- Publications: add one markdown file to `_publications/`
- Projects: add one markdown file to `_portfolio/`
- Travel notes: add one markdown file to `_travel/`
- PDFs, slides, bib files, images: `files/` and `images/`
- Top navigation: `_data/navigation.yml`

## Add New Content

You can create a draft entry with the helper script:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\new-entry.ps1 -Type publication -Title "My New Paper" -Slug "my-new-paper" -Date 2026-05-20 -Venue "IEEE Conference"
```

Available types:

- `publication`
- `project`
- `travel`

The script creates a markdown file with `published: false`. Fill in the details, then change it to `published: true` when you are ready to publish.

## Publish To GitHub

```powershell
git status
git add .
git commit -m "Update homepage"
git push
```

## Notes

- The home page now shows only a short introduction and recent publications. The full paper list is managed in `_publications/`.
- The `Projects` page is backed by `_portfolio/`.
- The `Travel` page is backed by `_travel/`.

## File Management

Use `files/` with fixed subfolders instead of putting everything in one flat directory:

- Paper PDFs: `files/papers/`
- Slides PDFs or PPTX: `files/slides/`
- BibTeX: `files/bib/`
- Old template leftovers or archival files: `files/archive/`

Recommended workflow for a new publication:

1. Upload the paper PDF to `files/papers/`
2. Upload slides to `files/slides/` if you want them public
3. Update the matching file in `_publications/`
4. Set paths like:
   - `paperurl: "/files/papers/your-paper.pdf"`
   - `slidesurl: "/files/slides/your-slides.pdf"`

If a paper does not have a public PDF yet, leave `paperurl` empty.
