"""draw kitty tab"""
# pyright: reportMissingImports=false
# pylint: disable=E0401,C0116,C0103,W0603,R0913

from kitty.fast_data_types import Screen, get_options, get_boss
from kitty.utils import color_as_int
from kitty.tab_bar import DrawData, ExtraData, TabBarData, draw_title, as_rgb

opts = get_options()

# Dictionary of tab colors
tab_colors = {
    1: opts.color9, 
    2: opts.color12,
    3: opts.color10,
    4: opts.color13,
    5: opts.active_tab_background,
    6: opts.active_tab_background,
    7: opts.active_tab_background,
    8: opts.active_tab_background,
    9: opts.active_tab_background,
}

mappings = {
    1: "ʰ", 
    2: "ʲ",
    3: "ᵏ",
    4: "ˡ",
}


def to_sup(s):
    sups = {u'0': u'\u2070',
            u'1': u'\xb9',
            u'2': u'\xb2',
            u'3': u'\xb3',
            u'4': u'\u2074',
            u'5': u'\u2075',
            u'6': u'\u2076',
            u'7': u'\u2077',
            u'8': u'\u2078',
            u'9': u'\u2079'}

    return ''.join(sups.get(char, char) for char in s)

def get_active_tab_index() -> int:
    return get_boss().active_tab_manager.active_tab_idx + 1

def draw_tab(
    draw_data: DrawData, screen: Screen, tab: TabBarData,
    before: int, max_title_length: int, index: int, is_last: bool,
    extra_data: ExtraData
) -> int:
    orig_fg = screen.cursor.fg
    orig_bg = screen.cursor.bg
    left_sep, right_sep = ('', '')
    active_tab_idx = get_active_tab_index()
    tabIsActive = index == active_tab_idx
    nextTabIsActive = index + 1 == active_tab_idx
    default_bg = as_rgb(int(draw_data.default_bg))
    inactive_tab_bg = as_rgb(color_as_int(opts.inactive_tab_background))

    custom_bg = as_rgb(color_as_int(opts.color9))
    next_tab_custom_bg = as_rgb(color_as_int(opts.color9)) 
    tab_bg = custom_bg if tabIsActive else orig_bg


    def draw_sep() -> None:
        if is_last:
            separator_bg = default_bg
        elif nextTabIsActive:
            separator_bg = next_tab_custom_bg
        else:
            separator_bg = inactive_tab_bg

        if tabIsActive:
           separator_fg = custom_bg
        elif not nextTabIsActive:
           separator_fg = custom_bg
        else:
           separator_fg = inactive_tab_bg

        screen.cursor.bg = separator_bg
        screen.cursor.fg = separator_fg

        separator_char = '' if tabIsActive or nextTabIsActive or is_last else "╱"
        screen.draw(separator_char) if not is_last else None


    if max_title_length <= 1:
        screen.draw('…')
    elif max_title_length == 2:
        screen.draw('…|')
    else:
        screen.draw('')
        screen.cursor.bg = tab_bg
        draw_title(draw_data, screen, tab, index)
        map_indicator = mappings.get(index, to_sup(str(index)))
        screen.draw(f'{map_indicator} ')
        draw_sep()
        screen.cursor.bg = orig_bg
        screen.cursor.fg = orig_fg

    return screen.cursor.x
