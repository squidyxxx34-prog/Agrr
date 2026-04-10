# Auto-push GitHub pour `index.html`

Script fourni: `scripts/autopush-index.sh`

## Prérequis
- Git configuré avec un remote `origin` qui pointe vers GitHub.
- Permissions push (SSH key ou token).
- Linux avec `inotify-tools`:

```bash
sudo apt-get install -y inotify-tools
```

## Lancer l'auto-push

```bash
./scripts/autopush-index.sh
```

Options:

```bash
./scripts/autopush-index.sh <fichier> <branche> <remote>
```

Exemple:

```bash
./scripts/autopush-index.sh index.html main origin
```

Le script:
1. surveille le fichier,
2. commit automatiquement quand il change,
3. push vers GitHub.
