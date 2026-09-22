# Custom kitty tab bar renderer.
# Centered normal tabs + a rounded Nord cwd pill on the left.

import os

from kitty.fast_data_types import get_boss, wcswidth
from kitty.rgb import to_color

BAR = "#2e3440"          # nord0
ACTIVE = "#88c0d0"       # nord8
ACTIVE_FG = "#2e3440"    # nord0
INACTIVE_FG = "#4c566a"  # nord3

LEFT = ""
RIGHT = ""
TAB_ICON = "󰓩"
CWD_ICON = ""

LEFT_CWD_MAX = 32


def as_rgb(hex_color: str) -> int:
    return (int(to_color(hex_color)) << 8) | 2


def fit(text: str, width: int) -> str:
    if width <= 0:
        return ""
    if wcswidth(text) <= width:
        return text
    out = ""
    used = 0
    for ch in text:
        cw = max(wcswidth(ch), 0)
        if used + cw >= width:
            return out + "…"
        out += ch
        used += cw
    return out


def fit_left(text: str, width: int) -> str:
    """Trim from the left, keeping the current directory visible."""
    if width <= 0:
        return ""
    if wcswidth(text) <= width:
        return text
    keep = width - 1
    out = ""
    used = 0
    for ch in reversed(text):
        cw = max(wcswidth(ch), 0)
        if used + cw > keep:
            break
        out = ch + out
        used += cw
    return "…" + out


def pretty_cwd(path: str) -> str:
    home = os.path.expanduser("~")
    if path == home:
        return "~"
    if path.startswith(home + os.sep):
        return "~" + path[len(home):]
    return path


def active_cwd() -> str:
    tab = get_boss().active_tab
    cwd = (tab.get_cwd_of_active_window() if tab else None) or "~"
    return pretty_cwd(cwd)


def smart_cwd(path: str, width: int) -> str:
    if wcswidth(path) <= width:
        return path

    parts = [p for p in path.split(os.sep) if p]
    if not parts:
        return fit(path, width)

    if path.startswith("~/"):
        candidates = ["~/" + os.sep.join(parts[-2:]), "~/…/" + parts[-1], "…/" + parts[-1]]
    elif path.startswith(os.sep):
        candidates = ["/…/" + os.sep.join(parts[-2:]), "/…/" + parts[-1], "…/" + parts[-1]]
    else:
        candidates = ["…/" + os.sep.join(parts[-2:]), "…/" + parts[-1]]

    for c in candidates:
        if wcswidth(c) <= width:
            return c
    return fit_left(parts[-1], width)


def draw_left_cwd(screen) -> None:
    """Draw a cwd pill at the far left without participating in tab layout."""
    old_x = screen.cursor.x
    old_fg = screen.cursor.fg
    old_bg = screen.cursor.bg

    bar = as_rgb(BAR)
    active = as_rgb(ACTIVE)
    active_fg = as_rgb(ACTIVE_FG)

    text = f"{CWD_ICON} {smart_cwd(active_cwd(), LEFT_CWD_MAX)}"

    screen.cursor.x = 0
    screen.cursor.bg = bar
    screen.cursor.fg = active
    screen.draw(LEFT)

    screen.cursor.bg = active
    screen.cursor.fg = active_fg
    screen.draw(f" {text} ")

    screen.cursor.bg = bar
    screen.cursor.fg = active
    screen.draw(RIGHT)

    screen.cursor.x = old_x
    screen.cursor.fg = old_fg
    screen.cursor.bg = old_bg


def draw_tab(draw_data, screen, tab, before, max_tab_length, index, is_last, extra_data):
    bar = as_rgb(BAR)
    active = as_rgb(ACTIVE)
    active_fg = as_rgb(ACTIVE_FG)
    inactive_fg = as_rgb(INACTIVE_FG)

    if index == 1 and not extra_data.for_layout:
        draw_left_cwd(screen)

    suffix = ""
    if tab.needs_attention:
        suffix += draw_data.bell_on_tab
    if tab.has_activity_since_last_focus:
        suffix += draw_data.tab_activity_symbol

    # Old behavior: tabs show their normal kitty/window title again.
    title = f"{index} {TAB_ICON} {tab.title}{suffix}"

    screen.cursor.bold = False
    screen.cursor.italic = False

    if tab.is_active:
        available = max(1, min(max_tab_length - 4, wcswidth(title)))
        title = fit(title, available)

        screen.cursor.bg = bar
        screen.cursor.fg = active
        screen.draw(LEFT)

        screen.cursor.bg = active
        screen.cursor.fg = active_fg
        screen.draw(f" {title} ")

        screen.cursor.bg = bar
        screen.cursor.fg = active
        screen.draw(RIGHT)
    else:
        title = fit(title, max_tab_length)
        screen.cursor.bg = bar
        screen.cursor.fg = inactive_fg
        screen.draw(title)

    screen.cursor.bg = bar
    screen.cursor.fg = inactive_fg
    if not is_last:
        screen.draw(" ")
    return screen.cursor.x
