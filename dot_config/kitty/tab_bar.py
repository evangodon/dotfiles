from kitty.fast_data_types import Screen, get_options
from kitty.utils import color_as_int
from kitty.tab_bar import DrawData, ExtraData, TabBarData, draw_title, as_rgb

opts = get_options()

# Dictionary of tab colors
tab_colors = {
    1: opts.color1, 
    2: opts.color4,
    3: opts.color2,
    4: opts.color3,
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

def draw_tab(
    draw_data: DrawData, screen: Screen, tab: TabBarData,
    before: int, max_title_length: int, index: int, is_last: bool,
    extra_data: ExtraData
) -> int:
    orig_fg = screen.cursor.fg
    orig_bg = screen.cursor.bg
    left_sep, right_sep = ('', '')

    custom_bg = as_rgb(color_as_int(tab_colors[index])) 
    tab_bg = custom_bg if tab.is_active else orig_bg

    def draw_sep(which: str) -> None:
        screen.cursor.bg = draw_data.default_bg
        screen.cursor.fg = orig_bg
        screen.draw(which)
        screen.cursor.bg = orig_bg
        screen.cursor.fg = orig_fg

    if max_title_length <= 1:
        screen.draw('…')
    elif max_title_length == 2:
        screen.draw('…|')
    elif max_title_length < 6:
        draw_sep(left_sep)
        screen.draw((' ' if max_title_length == 5 else '') + '…' + (' ' if max_title_length >= 4 else ''))
        draw_sep(right_sep)
    else:
        draw_sep(left_sep)
        screen.draw('')
        screen.cursor.bg = tab_bg
        draw_title(draw_data, screen, tab, index)
        map_indicator = mappings.get(index, to_sup(str(index)))
        screen.draw(f'{map_indicator} ')
        screen.cursor.bg = orig_bg
        extra = screen.cursor.x - before - max_title_length
        if extra >= 0:
            screen.cursor.x -= extra + 3
            screen.draw('…')
        elif extra == -1:
            screen.cursor.x -= 2
            screen.draw('…')
        screen.draw('')
        draw_sep(right_sep)
        draw_sep(' ')

    return screen.cursor.x
