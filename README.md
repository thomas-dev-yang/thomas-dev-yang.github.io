# Blog

Requires Nix with flakes enabled.

```sh
./build       # rebuild public/
./serve       # serve public/ at http://127.0.0.1:8000
nix build     # build into result/
```

`content/<path>.md` builds to `public/<path>.html`.

Posts with local assets can use a directory instead:

```text
content/math/off-dft-bin/
  index.md
  widget.html
  data.csv
```

This builds to `public/math/off-dft-bin/index.html`, with the other files
copied alongside it. All non-Markdown files under `content/` are copied with
their relative paths preserved, including nested directories. Keep only files
intended for publication there. Assets cannot overwrite generated pages or
shared site files. Markdown files are rendered as pages.

Link either post format from the homepage with `[[math/off-dft-bin]]`.
Directory posts use the URL `/math/off-dft-bin/`; standalone posts retain
their `.html` URLs. Don't create both `<path>.md` and `<path>/index.md` for
the same homepage link.

Reference bundled assets with relative paths in the post. For example:

```html
<iframe src="widget.html" title="Frequency projection"
  width="100%" height="780" style="border: 0;"></iframe>
```

A widget can keep its HTML, CSS, and JavaScript in that one local file.
No widget-specific template or build changes are needed. Run `./build` after
moving or deleting files so stale outputs are removed.

Homepage post lists sort newest first using the same `date:` metadata shown
beside each title. Posts with the same date sort by path alphabetically.
File timestamps and the order of links in `content/index.md` do not affect sorting.

Pushes to `main` deploy through `.github/workflows/pages.yml`. The repository's
Pages source must be set to **GitHub Actions**.
