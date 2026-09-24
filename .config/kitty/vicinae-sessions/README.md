# Kitty Sessions for Vicinae

Search for **Kitty Sessions** in Vicinae, open the command, and select a session.
Enter launches it in a new Kitty window.

Reads `$XDG_CONFIG_HOME/kitty/sessions` (default `~/.config/kitty/sessions`).
Recognizes `.kitty-session`, `.kitty_session`, and `.session` files.
The list refreshes on opening and every two seconds while mounted.
New session files need no rebuild. Session programs execute when selected.

## Build/install

```sh
cd ~/.config/kitty/vicinae-sessions
npm install
npm run typecheck
npm run build
```

The build installs to `~/.local/share/vicinae/extensions/kitty-sessions`.
Restart Vicinae if the command is not visible after its first installation.

This is a single searchable command containing a session picker, not one
root-search entry per session.
