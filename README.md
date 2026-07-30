# shelter

Requires Nix with flakes enabled.

```sh
./build       # rebuild public/
./serve       # serve public/ at http://127.0.0.1:8000
nix build     # build into result/
```

`content/<path>.md` builds to `public/<path>.html`.

Pushes to `main` deploy through `.github/workflows/pages.yml`. The repository's
Pages source must be set to **GitHub Actions**.
