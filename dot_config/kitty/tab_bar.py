"""draw kitty tab"""
# pyright: reportMissingImports=false
# pylint: disable=E0401,C0116,C0103,W0603,R0913

from kitty.rgb import Color
from kitty.fast_data_types import Screen, get_options, get_boss
from kitty.utils import color_as_int
from kitty.tab_bar import DrawData, ExtraData, TabBarData, draw_title, as_rgb

opts = get_options()

mappings = {
    1: "ʰ",
    2: "ʲ",
    3: "ᵏ",
    4: "ˡ",
}


def to_sup(s):
    sups = {
        "0": "\u2070",
        "1": "\xb9",
        "2": "\xb2",
        "3": "\xb3",
        "4": "\u2074",
        "5": "\u2075",
        "6": "\u2076",
        "7": "\u2077",
        "8": "\u2078",
        "9": "\u2079",
    }

    return "".join(sups.get(char, char) for char in s)


def darken_color(color: Color, factor: float) -> Color:
    r, g, b = color.r, color.g, color.b

    r = max(0, int(r * (1 - factor)))
    g = max(0, int(g * (1 - factor)))
    b = max(0, int(b * (1 - factor)))

    return Color(r, g, b)


def get_active_tab_index() -> int:
    return get_boss().active_tab_manager.active_tab_idx + 1


white_text_color = as_rgb(color_as_int(opts.color7))
red_color = opts.color9
primary_color = as_rgb(color_as_int(red_color))
active_tab_bg = as_rgb(color_as_int(opts.active_tab_background))
active_tab_fg = as_rgb(color_as_int(opts.active_tab_foreground))
inactive_tab_bg = as_rgb(color_as_int(opts.inactive_tab_background))
inactive_tab_fg = as_rgb(color_as_int(opts.inactive_tab_foreground))


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    active_tab_idx = get_active_tab_index()
    tab_is_active = index == active_tab_idx
    next_tab_is_active = index + 1 == active_tab_idx
    map_indicator = mappings.get(index, to_sup(str(index)))
    tab_needs_attention = tab.needs_attention

    # Colors
    orig_fg = screen.cursor.fg
    orig_bg = screen.cursor.bg
    default_bg = as_rgb(color_as_int(draw_data.default_bg))

    def draw_sep() -> None:
        if is_last and tab_is_active:
            separator_bg = active_tab_bg
        elif is_last:
            separator_bg = inactive_tab_bg
        elif next_tab_is_active:
            separator_bg = active_tab_bg
        else:
            separator_bg = inactive_tab_bg

        if is_last:
            separator_fg = default_bg
        elif tab_is_active:
            separator_fg = active_tab_bg
        elif next_tab_is_active:
            separator_fg = inactive_tab_bg
        else:
            separator_fg = active_tab_bg

        screen.cursor.bg = separator_bg
        screen.cursor.fg = separator_fg

        separator_char = "" if tab_is_active or next_tab_is_active or is_last else "╱"
        screen.draw(separator_char) if not is_last else screen.draw("")

    if max_title_length <= 1:
        screen.draw("…")
    elif max_title_length == 2:
        screen.draw("…|")
    else:
        screen.draw("")
        screen.draw("  ") if tab_needs_attention else screen.draw("   ")
        draw_title(draw_data, screen, tab, index)
        screen.draw(f" {map_indicator}")
        screen.draw("  ")
        draw_sep()
        screen.cursor.bg = orig_bg
        screen.cursor.fg = orig_fg

    return screen.cursor.x
