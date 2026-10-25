"""Generate the Cecil mod's derived textures from the user's art in imgs/.

Run from the repo root:
    python -X utf8 tools/make_art.py [--preview DIR] [--icons DIR]

Writes src/Textures/<NAME>.dds + <NAME>.tex (uncompressed RGBA DDS, same layout as the other
textures here) and art/generated/<NAME>.png as the editable source, then adds any new texture to
its XLP package. --preview also writes contact sheets to DIR for review. --icons reads the
user's generated icons from DIR instead of imgs/icons/.

What it makes:
  Gawain's portraits
    LEADER_TSOD_GAWAIN_CECIL_NEUTRAL             731 x 1461  setup screen      } armoured Gawain, cut-out
    LEADER_TSOD_GAWAIN_CECIL_LOADING_FOREGROUND  731 x 1461  loading screen    } Processed Images/..._NEUTRAL.png
    FALLBACK_NEUTRAL_LEADER_TSOD_GAWAIN_CECIL    825 x 1024  diplomacy screen, figure in the left 643 px:
        seated Gawain, cut-out Processed Images/..._NEUTRAL-1.png of imgs/8ab7bc05….jpg (user's choice)
    LEADER_TSOD_GAWAIN_CECIL_DIPLOMACY_BACKGROUND 1920 x 1080 diplomacy background: the space scene
        imgs/57c9a50d….jpg, cropped so the planet sits behind Gawain (user's choice)
  Fog-of-war versions, from the current 256 px icons
    ICON_UNIT_TSOD_SCOUT_AMBER_FOW_*, ICON_UNIT_TSOD_GORGON_PLATFORM_FOW_*  (22 32 38 50 80 256)
    ICON_BUILDING_TSOD_MANA_OBELISK_FOW_*                                  (32 38 50 80 128 256)
  Great person portraits ICON_GREAT_PERSON_INDIVIDUAL_TSOD_CE_<NAME>_40/160/256: square bust crops of the
  character art in imgs/ for Rebecca, Hettie, Byron, Philip, Pitman and Leite; the other six from
  imgs/icons/greatperson_<name>.png
  once the user makes them. Writes src/Icons/TsoDCE_GreatPeopleIcons.xml.
  Icons from the user's images in imgs/icons/ (specs in docs/icon-prompts.md), each only once its
  image exists; until then the base-game icon it borrows stays:
    promotion_<name>.png  -> ICON_PROMOTION_TSOD_CE_<NAME>_32 (glyph on a tier-coloured badge)
    greatwork_<name>.png  -> ICON_GREATWORK_TSOD_CE_<NAME>_45/64/256
      (until then the great works use a scene from imgs/ printed as a poster, GREATWORK_ART)
    and rewrites src/Icons/TsoDCE_UnitPromotionIcons.xml / TsoDCE_GreatworkIcons.xml to match.
  Historic moments from imgs/ (MOMENTS): MOMENT_UNIT_TSOD_GORGON_PLATFORM 456 x 332.

Everything else in src/Textures is hand-made and left alone. Crops are in source-image pixels;
adjust them here and re-run. Same approach as tools/make_art.py in the Typhon mod.
"""
import os
import re
import struct
import sys

from PIL import Image, ImageChops, ImageDraw, ImageEnhance, ImageFilter, ImageOps

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
IMG = os.path.join(ROOT, 'imgs')
TEX_DIR = os.path.join(ROOT, 'src', 'Textures')
XLP_DIR = os.path.join(ROOT, 'src', 'XLPs')
GEN_DIR = os.path.join(ROOT, 'art', 'generated')

SRC_GAWAIN = os.path.join('Processed Images', 'LEADER_TSOD_GAWAIN_CECIL_NEUTRAL.png')
LEADER = 'LEADER_TSOD_GAWAIN_CECIL'
UNIT_GLYPHS = ['ICON_UNIT_TSOD_SCOUT_AMBER', 'ICON_UNIT_TSOD_GORGON_PLATFORM']
UNIT_SIZES = [22, 32, 38, 50, 80, 256]
M = 1024          # master canvas for icons

# Gawain cut-out (731 x 1461): head top at y=260, figure fills the width from y=720 down;
# the gauntlet touches the left edge, the sword blade and cape run off the right edge.
# Setup / loading portrait: drop 130 px of the empty top so the head sits ~10% down (was 18%).
NEUTRAL_BOX = (20, 130, 686, 1461)          # 666 x 1331, aspect of 731 x 1461
# Diplomacy screen (user's choice, 10-25): seated Gawain over the space scene, planet behind him.
# DiplomacyActionView anchors the fallback image by its LEFT edge at 0.60 of the screen width while he
# speaks (0.667 in normal diplomacy), vertically centred, so the figure in the left 580 px stands at about
# 75-82% across; the rest of the 825 px canvas runs off the right edge. LeaderScene stretches the
# background to the full screen (StretchMode Fill), so the planet goes at the same place in the background.
SRC_GAWAIN_SEATED = os.path.join('Processed Images', 'LEADER_TSOD_GAWAIN_CECIL_NEUTRAL-1.png')
# Seated cut-out (2048 x 4096): head top y=1420, head centre x=1250, hand on the temple reaches x=1850;
# cape runs off the left edge, arm off the right. Head to hips, head ~7% down, the whole arm included.
# No edge fades (user, 10-25: the figure is already narrow, fading it makes him a stick). Content left of
# the head pushes him further right on screen, so the head stays ~340 px from the image's left edge.
FALLBACK_BOX = (353, 1231, 2048, 3931)      # 1695 x 2700 -> 643 x 1024, in the 825 x 1024 canvas
SRC_DIPLO_BG = '57c9a50de27fe58a5dbac4a33ecf461d4c709593.jpg'
# 4000 x 2115; planet at x 1000-1850, y 900-1730. This 16:9 crop puts it at 54-100% across, 45% down.
DIPLO_BG_BOX = (0, 843, 1844, 1880)         # 1844 x 1037 -> 1920 x 1080

# FOW glyph colours (Typhon tools/icon_art.py unit_glyph): gold fill on a dark-brown outline
FOW_FILL = (201, 164, 106, 255)
FOW_EDGE = (52, 38, 24, 255)

BUILDING_ICON = 'ICON_BUILDING_TSOD_MANA_OBELISK'
BUILDING_SIZES = [32, 38, 50, 80, 128, 256]

ICON_DIR = os.path.join(IMG, 'icons')
ICON_XML_DIR = os.path.join(ROOT, 'src', 'Icons')
# (promotion, level, borrowed ICON_ATLAS_PROMOTIONS index, image name in imgs/icons/)
PROMOTIONS = [
    ('SHADOW_REALM', 1, 15, 'promotion_shadow_realm'),
    ('MASTER_THIEF', 1, 15, 'promotion_master_thief'),
    ('SHADOW_CREATURE', 2, 18, 'promotion_shadow_creature'),
    ('TAVERN_QUEEN', 2, 22, 'promotion_tavern_queen'),
    ('SHADOW_CHOSEN', 3, 17, 'promotion_shadow_chosen'),
    ('NIGHT_MISTRESS', 3, 5, 'promotion_night_mistress'),
    ('SHADOW_AUTHORITY', 4, 26, 'promotion_shadow_authority'),
]
# (great work, image name); both borrow ICON_ATLAS_GREATWORKS index 0 like every base-game writing work
GREATWORKS = [('IMMIGRANTS', 'greatwork_immigrants'), ('BEACON_FIRE', 'greatwork_beacon_fire')]
# Until the user's generated poster (imgs/icons/greatwork_*.png) exists, print a scene from imgs/ as the
# poster (user's new sketches, 10-25). Both works are magic films; the novel describes their posters.
GREATWORK_ART = {
    # 烽火: an old-era knight; the mounted knight charging under a banner (watermark below y=1220 left out)
    'BEACON_FIRE': ('场景——旧时代的骑士们.jpg', (0, 120, 753, 1180)),
    # 移民: the novel's poster is a ship of migrants; the magic train with a lone traveller and his dog
    'IMMIGRANTS': ('场景速写——魔能列车穿过原野2.jpg', (250, 28, 1650, 2000)),
}
# Historic moment illustrations made from the user's art (456 x 332 like the other three)
MOMENTS = {
    # The Gorgon platforms are the smaller siblings of the flying fortress 尘世黎明号 (novel vol. 6):
    # anti-gravity platform with a synthetic "main brain". Crop leaves out the watermark at bottom right.
    'MOMENT_UNIT_TSOD_GORGON_PLATFORM': ('尘世黎明号4.jpg', (0, 150, 2340, 1854)),
}
GREATWORK_SIZES = [45, 64, 256]
# Great person portraits, ICON_GREAT_PERSON_INDIVIDUAL_TSOD_CE_<NAME>. 256 fills the Civilopedia portrait
# slot (UI/CivilopediaPage_TsoDCE_GreatPersonPortraits.lua); 160 and 40 are what the "Real Great People"
# mod asks for on its own page and list, under the same icon name.
GP_SIZES = [40, 160, 256]
# (individual, source in imgs/ and square crop box with the head centred) or (individual, None, None):
# then the portrait comes from imgs/icons/greatperson_<name>.png once the user makes it.
GREAT_PEOPLE = [
    ('REBECCA_CECIL', '瑞贝卡·塞西尔.jpeg', (352, 85, 742, 475)),
    ('HETTIE_CECIL', '赫蒂·塞西尔.jpeg', (605, 40, 1185, 620)),
    ('BYRON_KIRK', '拜伦·柯克.jpeg', (305, 26, 585, 306)),
    ('SIR_PHILIP', '菲利普.jpg', (1225, 0, 2675, 1450)),
    ('NICHOLAS_EGG', None, None),
    ('PITMAN_LAUREN', '皮特曼·劳伦.jpg', (60, 0, 1020, 960)),
    ('FELM', None, None),
    ('JENNIE_PERRO', None, None),
    ('SANTIS_SAIDE', None, None),
    ('KAMEL_SLAYEN', None, None),
    ('NORRIS', None, None),
    ('LEITE_AVIKEN', '莱特.jpg', (252, 440, 622, 810)),
]
# Promotion badge colours by level, sampled from the base game's Promotions32.dds:
# (light top corners, dark lower corners, bottom of the inset diamond)
TIERS = {1: ((153, 131, 86), (98, 75, 35), (125, 105, 63)),      # bronze
         2: ((145, 136, 136), (93, 82, 80), (126, 121, 122)),    # silver
         3: ((179, 179, 77), (116, 114, 21), (144, 147, 47)),    # gold
         4: ((185, 180, 187), (127, 120, 125), (149, 145, 159))}  # platinum


# ----------------------------------------------------------------------------- DDS / TEX
def write_dds(img, path, mips=False):
    """Uncompressed 32-bit RGBA DDS (masks R=0xff, G=0xff00, B=0xff0000, A=0xff000000)."""
    img = img.convert('RGBA')
    levels = [img]
    if mips:
        w, h = img.size
        while w > 1 or h > 1:
            w, h = max(1, w // 2), max(1, h // 2)
            levels.append(img.resize((w, h), Image.LANCZOS))
    w, h = img.size
    flags = 0x1 | 0x2 | 0x4 | 0x8 | 0x1000 | (0x20000 if mips else 0)
    caps = 0x1000 | ((0x8 | 0x400000) if mips else 0)
    header = struct.pack('<4sIIIIIII44x', b'DDS ', 124, flags, h, w, w * 4, 0, len(levels))
    pf = struct.pack('<IIIIIIII', 32, 0x41, 0, 32, 0x000000ff, 0x0000ff00, 0x00ff0000, 0xff000000)
    tail = struct.pack('<IIIII', caps, 0, 0, 0, 0)
    with open(path, 'wb') as f:
        f.write(header + pf + tail)
        for lv in levels:
            f.write(lv.tobytes())
    return len(levels)


def read_dds(path):
    """Top mip of an uncompressed 32-bit DDS (RGBA or BGRA masks) as an RGBA image."""
    with open(path, 'rb') as f:
        d = f.read()
    h, w = struct.unpack('<II', d[12:20])
    bits, rm, gm, bm, am = struct.unpack('<IIIII', d[88:108])
    if bits != 32:
        raise ValueError('%s: only uncompressed 32-bit DDS is supported' % path)
    raw = d[128:128 + w * h * 4]
    if (rm, gm, bm, am) == (0xff, 0xff00, 0xff0000, 0xff000000):
        return Image.frombytes('RGBA', (w, h), raw)
    if (rm, gm, bm, am) == (0xff0000, 0xff00, 0xff, 0xff000000):
        return Image.frombytes('RGBA', (w, h), raw, 'raw', 'BGRA')
    raise ValueError('%s: unexpected channel masks' % path)


TEX = """<?xml version="1.0" encoding="UTF-8" ?>
<AssetObjects..TextureInstance>
	<m_ExportSettings>
		<ePixelformat>PF_R8G8B8A8_UNORM</ePixelformat>
		<eFilterType>FT_BOX</eFilterType>
		<bUseMips>{usemips}</bUseMips>
		<iNumManualMips>0</iNumManualMips>
		<bCompleteMipChain>false</bCompleteMipChain>
		<fValueClampMin>0.000000</fValueClampMin>
		<fValueClampMax>1.000000</fValueClampMax>
		<fSupportScale>1.000000</fSupportScale>
		<fGammaIn>2.200000</fGammaIn>
		<fGammaOut>2.200000</fGammaOut>
		<iSlabWidth>0</iSlabWidth>
		<iSlabHeight>0</iSlabHeight>
		<iColorKeyX>64</iColorKeyX>
		<iColorKeyY>64</iColorKeyY>
		<iColorKeyZ>64</iColorKeyZ>
		<eExportMode>TEXTURE_2D</eExportMode>
		<bSampleFromTopLayer>false</bSampleFromTopLayer>
	</m_ExportSettings>
	<m_CookParams>
		<m_Values/>
	</m_CookParams>
	<m_Version>
		<major>1</major>
		<minor>0</minor>
		<build>0</build>
		<revision>0</revision>
	</m_Version>
	<m_Height>{h}</m_Height>
	<m_Width>{w}</m_Width>
	<m_Depth>1</m_Depth>
	<m_NumMipMaps>{nummips}</m_NumMipMaps>
	<m_SourceFilePath text="art/generated/{name}.png"/>
	<m_SourceObjectName text=""/>
	<m_ImportedTime>0</m_ImportedTime>
	<m_ExportedTime>0</m_ExportedTime>
	<m_ClassName text="{cls}"/>
	<m_DataFiles>
		<Element>
			<m_ID text="DDS"/>
			<m_RelativePath text="{name}.dds"/>
		</Element>
	</m_DataFiles>
	<m_Name text="{name}"/>
	<m_Description text=""/>
	<m_Tags>
{tags}
	</m_Tags>
</AssetObjects..TextureInstance>
"""


def emit(img, name, fallback=False):
    """Save PNG source + DDS + TEX. Returns the image for previews."""
    img = img.convert('RGBA')
    img.save(os.path.join(GEN_DIR, name + '.png'))
    levels = write_dds(img, os.path.join(TEX_DIR, name + '.dds'), mips=fallback)
    if fallback:
        cls = 'Leader_Fallback'
        tags = '\t\t<Element text="Leader_Fallback"/>\n\t\t<Element text="Leader"/>\n\t\t<Element text="Fallback"/>'
    else:
        cls = 'UserInterface'
        tags = '\t\t<Element text="UserInterface"/>'
    with open(os.path.join(TEX_DIR, name + '.tex'), 'w', encoding='utf-8', newline='\n') as f:
        f.write(TEX.format(usemips='true' if levels > 1 else 'false', nummips=levels - 1,
                           h=img.height, w=img.width, name=name, cls=cls, tags=tags))
    return img


# ----------------------------------------------------------------------------- helpers
def crop_resize(img, box, size):
    return img.crop(box).resize(size, Image.LANCZOS)


def feather(img, left, top, right, bottom):
    """Fade alpha to 0 over the given pixel widths at each edge (softens where the cut-out's own
    crop runs off the canvas, so no straight cut line shows over the background)."""
    w, h = img.size
    mask = Image.new('L', (w, h), 0)
    px = mask.load()
    for y in range(h):
        fy = min(1.0, y / top if top else 1.0, (h - 1 - y) / bottom if bottom else 1.0)
        for x in range(w):
            fx = min(1.0, x / left if left else 1.0, (w - 1 - x) / right if right else 1.0)
            px[x, y] = int(255 * max(0.0, min(fx, fy)))
    out = img.copy()
    out.putalpha(ImageChops.multiply(img.getchannel('A'), mask))
    return out


def dilate(mask, px):
    for _ in range(max(1, px // 4)):
        mask = mask.filter(ImageFilter.MaxFilter(9))
    return mask


def solid(color, mask):
    out = Image.new('RGBA', mask.size, color)
    out.putalpha(ImageChops.multiply(mask, Image.new('L', mask.size, color[3])))
    return out


def fit_alpha(alpha, fill, canvas=M):
    """Trim to the bounding box and centre it so its larger side is fill * canvas."""
    alpha = alpha.crop(alpha.point(lambda v: 255 if v > 8 else 0).getbbox())
    scale = fill * canvas / max(alpha.size)
    alpha = alpha.resize((max(1, round(alpha.width * scale)), max(1, round(alpha.height * scale))), Image.LANCZOS)
    out = Image.new('L', (canvas, canvas), 0)
    out.paste(alpha, ((canvas - alpha.width) // 2, (canvas - alpha.height) // 2))
    return out


def icon_sizes(src, base, sizes):
    return [emit(src.resize((s, s), Image.LANCZOS), '%s_%d' % (base, s)) for s in sizes]


# ----------------------------------------------------------------------------- art
def portraits():
    src = Image.open(os.path.join(IMG, SRC_GAWAIN)).convert('RGBA')
    if src.size != (731, 1461):
        raise SystemExit('%s is %dx%d; the crop boxes assume 731x1461' % (SRC_GAWAIN, *src.size))
    neutral = feather(crop_resize(src, NEUTRAL_BOX, (731, 1461)), 30, 0, 60, 90)
    made = {'neutral': emit(neutral, LEADER + '_NEUTRAL')}
    emit(neutral, LEADER + '_LOADING_FOREGROUND')
    seated = Image.open(os.path.join(IMG, SRC_GAWAIN_SEATED)).convert('RGBA')
    if seated.size != (2048, 4096):
        raise SystemExit('%s is %dx%d; FALLBACK_BOX assumes 2048x4096' % (SRC_GAWAIN_SEATED, *seated.size))
    bw, bh = FALLBACK_BOX[2] - FALLBACK_BOX[0], FALLBACK_BOX[3] - FALLBACK_BOX[1]
    fig = crop_resize(seated, FALLBACK_BOX, (round(bw * 1024 / bh), 1024))
    fallback = Image.new('RGBA', (825, 1024), (0, 0, 0, 0))
    fallback.alpha_composite(fig, (0, 0))
    made['fallback'] = emit(fallback, 'FALLBACK_NEUTRAL_' + LEADER, fallback=True)
    bg = Image.open(os.path.join(IMG, SRC_DIPLO_BG)).convert('RGBA')
    made['diplo_bg'] = emit(crop_resize(bg, DIPLO_BG_BOX, (1920, 1080)), LEADER + '_DIPLOMACY_BACKGROUND')
    made['source'] = src
    return made


def fow_glyph(icon):
    """Fog-of-war version of a white unit glyph: gold fill with a thick dark-brown outline."""
    a = fit_alpha(icon.getchannel('A').resize((M, M), Image.LANCZOS), 0.80)
    fow = Image.new('RGBA', (M, M), (0, 0, 0, 0))
    fow.alpha_composite(solid(FOW_EDGE, dilate(a, 44)))
    fow.alpha_composite(solid(FOW_FILL, a))
    return fow


def fow_icons():
    made = {}
    for base in UNIT_GLYPHS:
        icon = read_dds(os.path.join(TEX_DIR, base + '_256.dds'))
        made[base] = (icon, icon_sizes(fow_glyph(icon), base + '_FOW', UNIT_SIZES))
    return made


def sepia(img, tone=(214, 178, 120), contrast=0.85, brightness=1.0):
    """Building FOW look (Typhon icon_art.py / art_pipeline.py): the painted icon toned brown-gold."""
    a = img.getchannel('A')
    gray = ImageEnhance.Contrast(img.convert('L')).enhance(contrast)
    gray = ImageEnhance.Brightness(gray).enhance(brightness)
    col = ImageOps.colorize(gray, black=(40, 28, 16), white=tone).convert('RGBA')
    col.putalpha(a)
    return col


def building_fow():
    icon = read_dds(os.path.join(TEX_DIR, BUILDING_ICON + '_256.dds'))
    return icon, icon_sizes(sepia(icon), BUILDING_ICON + '_FOW', BUILDING_SIZES)


# ----------------------------------------------------------------------------- user icons
def find_image(folder, stem):
    """The user's image for stem in .png / .jpg / .jpeg / .webp (most recently saved wins), or None."""
    found = [os.path.join(folder, stem + ext) for ext in ('.png', '.jpg', '.jpeg', '.webp')
             if os.path.exists(os.path.join(folder, stem + ext))]
    return Image.open(max(found, key=os.path.getmtime)).convert('RGB') if found else None


def key_white_glyph(img):
    """Black glyph on white -> alpha from darkness."""
    return ImageOps.invert(img.convert('L')).point(lambda v: min(255, int(v * 1.15)))


def key_magenta(img, bg=(252, 25, 251)):
    """Subject on flat magenta -> RGBA. Soft edges are un-mixed from the background colour so
    smoke and glow keep their own colour instead of a pink fringe (Typhon icon_art.py)."""
    rgb = img.convert('RGB')
    span = min(bg[0], bg[2]) - bg[1]
    out = []
    for r, g, b in getattr(rgb, 'get_flattened_data', rgb.getdata)():
        a = 1.0 - max(0.0, min(1.0, (min(r, b) - g) / span))
        if a <= 0.08:
            out.append((0, 0, 0, 0))
            continue
        if a < 1.0:
            r, g, b = (max(0, min(255, int((c - (1 - a) * k) / a))) for c, k in zip((r, g, b), bg))
        out.append((r, g, b, int(a * 255)))
    res = Image.new('RGBA', rgb.size)
    res.putdata(out)
    return res


def fit_rgba(img, fill, canvas=M):
    """Trim to the alpha bounding box and centre it so its larger side is fill * canvas."""
    img = img.crop(img.getchannel('A').point(lambda v: 255 if v > 8 else 0).getbbox())
    scale = fill * canvas / max(img.size)
    img = img.resize((max(1, round(img.width * scale)), max(1, round(img.height * scale))), Image.LANCZOS)
    out = Image.new('RGBA', (canvas, canvas), (0, 0, 0, 0))
    out.alpha_composite(img, ((canvas - img.width) // 2, (canvas - img.height) // 2))
    return out


def _poly(points, size):
    m = Image.new('L', (size, size), 0)
    ImageDraw.Draw(m).polygon(points, fill=255)
    return m


def _vgradient(size, top, bottom, y0, y1):
    g = Image.new('RGBA', (size, size))
    d = ImageDraw.Draw(g)
    for y in range(size):
        t = min(1.0, max(0.0, (y - y0) / float(y1 - y0)))
        d.line((0, y, size, y), fill=tuple(int(top[i] + (bottom[i] - top[i]) * t) for i in range(3)) + (255,))
    return g


def _mix(c, other, t):
    return tuple(int(c[i] + (other[i] - c[i]) * t) for i in range(3))


def promotion_badge(glyph_alpha, level, S=512):
    """32 px promotion icon in the base game's style: pentagon shield, black rim, light top corners,
    a darker inset diamond, light glyph with a drop shadow; shield colour by level."""
    light, dark, low = TIERS[level]
    u = S / 32.0
    pts = lambda seq: [(x * u, y * u) for x, y in seq]
    out = Image.new('RGBA', (S, S), (0, 0, 0, 0))
    out.alpha_composite(solid((14, 10, 8, 255), _poly(pts([(3.4, 3.4), (28.6, 3.4), (28.6, 19.6), (16, 31.2), (3.4, 19.6)]), S)))
    face = _poly(pts([(4.6, 4.6), (27.4, 4.6), (27.4, 19.1), (16, 29.6), (4.6, 19.1)]), S)
    white = (255, 255, 255)
    # corners outside the diamond: bright at the top, dark at the lower sides
    corners = _vgradient(S, _mix(light, white, 0.3), dark, 4.6 * u, 18 * u)
    corners.putalpha(face)
    out.alpha_composite(corners)
    # the inset diamond, as four facets lit from the top
    top, right, bottom, left, c = (16, 4.6), (27.4, 16.6), (16, 29.6), (4.6, 16.6), (16, 16.6)
    for tri, col in (((left, top, c), _mix(light, white, 0.12)), ((top, right, c), _mix(light, dark, 0.2)),
                     ((right, bottom, c), _mix(low, dark, 0.35)), ((bottom, left, c), low)):
        out.alpha_composite(solid(col + (255,), ImageChops.multiply(_poly(pts(tri), S), face)))
    # bevels: light along the upper diamond edges, dark along the lower ones
    bevel = Image.new('RGBA', (S, S), (0, 0, 0, 0))
    d = ImageDraw.Draw(bevel)
    w = max(1, int(0.8 * u))
    d.line(pts([left, top, right]), fill=_mix(light, white, 0.55) + (200,), width=w)
    d.line(pts([left, bottom, right]), fill=_mix(dark, (0, 0, 0), 0.3) + (170,), width=w)
    out.alpha_composite(bevel)
    g = fit_alpha(glyph_alpha, 15.0 / 32, S)                      # glyph about 15 px of the 32
    shift = int(0.9 * u)
    shadow = Image.new('L', (S, S), 0)
    shadow.paste(g, (shift, shift))
    out.alpha_composite(solid((10, 6, 4, 190), ImageChops.multiply(shadow, face)))
    out.alpha_composite(solid(_mix(light, (255, 255, 255), 0.7) + (255,), ImageChops.multiply(g, face)))
    return out.resize((32, 32), Image.LANCZOS)


def poster(scene):
    """A scene printed as a paper poster, as a small object like the base game's great work icons:
    warm print tone, off-white paper margin, a few degrees of tilt and a soft drop shadow."""
    w = 600
    h = round(w * scene.height / scene.width)
    gray = ImageOps.autocontrast(scene.convert('L').resize((w, h), Image.LANCZOS), cutoff=1)
    printed = ImageOps.colorize(gray, black=(34, 26, 20), white=(244, 232, 208)).convert('RGBA')
    pad = 26
    sheet = Image.new('RGBA', (w + 2 * pad, h + 2 * pad), (232, 220, 194, 255))
    ImageDraw.Draw(sheet).rectangle((pad - 6, pad - 6, w + pad + 5, h + pad + 5), outline=(170, 150, 120, 255), width=2)
    sheet.paste(printed, (pad, pad))
    sheet = sheet.rotate(-5, resample=Image.BICUBIC, expand=True)
    canvas = Image.new('RGBA', (sheet.width + 80, sheet.height + 80), (0, 0, 0, 0))
    shadow = solid((0, 0, 0, 140), sheet.getchannel('A')).filter(ImageFilter.GaussianBlur(14))
    canvas.alpha_composite(shadow, (48, 52))
    canvas.alpha_composite(sheet, (36, 36))
    return fit_rgba(canvas, 0.94)


def moments():
    made = {}
    for name, (src, box) in MOMENTS.items():
        made[name] = emit(crop_resize(Image.open(os.path.join(IMG, src)).convert('RGBA'), box, (456, 332)), name)
    return made


def user_icons(icon_dir):
    """Promotion and great-work icons from the user's images; returns (made, custom promos, custom works)."""
    made, promos, works = {}, [], []
    for name, level, _index, stem in PROMOTIONS:
        src = find_image(icon_dir, stem)
        if src is None:
            continue
        glyph = key_white_glyph(src.resize((M, M), Image.LANCZOS))
        made['ICON_PROMOTION_TSOD_CE_' + name] = emit(promotion_badge(glyph, level), 'ICON_PROMOTION_TSOD_CE_%s_32' % name)
        promos.append(name)
    for name, stem in GREATWORKS:
        src = find_image(icon_dir, stem)
        if src is not None:
            master = fit_rgba(key_magenta(src.resize((M, M), Image.LANCZOS)), 0.94)
        elif name in GREATWORK_ART:
            art, box = GREATWORK_ART[name]
            master = poster(Image.open(os.path.join(IMG, art)).convert('RGB').crop(box))
        else:
            continue
        made['ICON_GREATWORK_TSOD_CE_' + name] = icon_sizes(master, 'ICON_GREATWORK_TSOD_CE_' + name, GREATWORK_SIZES)[-1]
        works.append(name)
    return made, promos, works


def great_person_portraits(icon_dir):
    """Square bust portraits: crops of the user's character art, or the user's generated images."""
    made = {}
    for name, src, box in GREAT_PEOPLE:
        if src:
            img = Image.open(os.path.join(IMG, src)).convert('RGBA').crop(box)
        else:
            img = find_image(icon_dir, 'greatperson_' + name.lower())
            if img is None:
                continue
            side = min(img.size)                               # centre-crop to square if needed
            img = img.crop(((img.width - side) // 2, (img.height - side) // 2,
                            (img.width + side) // 2, (img.height + side) // 2)).convert('RGBA')
        base = 'ICON_GREAT_PERSON_INDIVIDUAL_TSOD_CE_' + name
        made[name] = icon_sizes(img, base, GP_SIZES)[-1]
    return made


def write_great_people_xml(names):
    atlases = ''.join('        <Row Name="ATLAS_ICON_GREAT_PERSON_INDIVIDUAL_TSOD_CE_%s" IconSize="%d" '
                      'Filename="ICON_GREAT_PERSON_INDIVIDUAL_TSOD_CE_%s_%d" />\n' % (n, s, n, s)
                      for n in names for s in GP_SIZES)
    defs = ''.join('        <Row Name="ICON_GREAT_PERSON_INDIVIDUAL_TSOD_CE_%s" '
                   'Atlas="ATLAS_ICON_GREAT_PERSON_INDIVIDUAL_TSOD_CE_%s" Index="0" />\n' % (n, n) for n in names)
    text = ('<?xml version="1.0" encoding="utf-8"?>\n'
            '<!-- Written by tools/make_art.py: one atlas per great person that has a portrait. The Civilopedia\n'
            '     shows ICON_<GreatPersonIndividualType> through UI/CivilopediaPage_TsoDCE_GreatPersonPortraits.lua;\n'
            '     great people without one keep the unit icon. -->\n<GameData>\n'
            '    <IconTextureAtlases>\n%s    </IconTextureAtlases>\n'
            '    <IconDefinitions>\n%s    </IconDefinitions>\n</GameData>' % (atlases, defs))
    return write_if_changed(os.path.join(ICON_XML_DIR, 'TsoDCE_GreatPeopleIcons.xml'), text)


def write_if_changed(path, text):
    data = text.replace('\n', '\r\n').encode('utf-8')          # these XML files are CRLF, no final newline
    if os.path.exists(path):
        with open(path, 'rb') as f:
            if f.read() == data:
                return False
    with open(path, 'wb') as f:
        f.write(data)
    return True


def write_icon_xml(promos, works):
    """Each promotion / great work points at its own atlas once its image exists, else at the base-game icon."""
    atlases = ''.join('        <Row Name="ATLAS_ICON_PROMOTION_TSOD_CE_%s" IconSize="32" Filename="ICON_PROMOTION_TSOD_CE_%s_32" />\n'
                      % (n, n) for n in promos)
    defs = ''.join('        <Row Name="ICON_PROMOTION_TSOD_CE_%s" Atlas="%s" Index="%d" />\n'
                   % (n, 'ATLAS_ICON_PROMOTION_TSOD_CE_' + n if n in promos else 'ICON_ATLAS_PROMOTIONS', 0 if n in promos else i)
                   for n, _lv, i, _s in PROMOTIONS)
    text = ('<?xml version="1.0" encoding="utf-8"?>\n<GameInfo>\n'
            + ('    <IconTextureAtlases>\n%s    </IconTextureAtlases>\n' % atlases if promos else '')
            + '    <IconDefinitions>\n%s    </IconDefinitions>\n</GameInfo>' % defs)
    changed = write_if_changed(os.path.join(ICON_XML_DIR, 'TsoDCE_UnitPromotionIcons.xml'), text)
    atlases = ''.join('        <Row Name="ATLAS_ICON_GREATWORK_TSOD_CE_%s" IconSize="%d" Filename="ICON_GREATWORK_TSOD_CE_%s_%d" />\n'
                      % (n, s, n, s) for n in works for s in GREATWORK_SIZES)
    defs = ''.join('        <Row Name="ICON_GREATWORK_TSOD_CE_%s" Atlas="%s" Index="0" />\n'
                   % (n, 'ATLAS_ICON_GREATWORK_TSOD_CE_' + n if n in works else 'ICON_ATLAS_GREATWORKS')
                   for n, _s in GREATWORKS)
    text = ('<?xml version="1.0" encoding="UTF-8"?>\n<GameData>\n'
            + ('    <IconTextureAtlases>\n%s    </IconTextureAtlases>\n' % atlases if works else '')
            + '    <IconDefinitions>\n%s    </IconDefinitions>\n</GameData>' % defs)
    return changed | write_if_changed(os.path.join(ICON_XML_DIR, 'TsoDCE_GreatworkIcons.xml'), text)


# ----------------------------------------------------------------------------- packages
XLP_ENTRY = '\t\t<Element>\n\t\t\t<m_EntryID text="{0}"/>\n\t\t\t<m_ObjectName text="{0}"/>\n\t\t</Element>\n'


def ensure_xlp_entries(xlp, names):
    """Append entries the package does not have yet; the rest of the hand-made XLP stays as it is."""
    path = os.path.join(XLP_DIR, xlp)
    with open(path, encoding='utf-8') as f:
        text = f.read()
    have = set(re.findall(r'<m_EntryID text="([^"]*)"', text))
    new = [n for n in names if n not in have]
    if new:
        text = text.replace('\t</m_Entries>', ''.join(XLP_ENTRY.format(n) for n in new) + '\t</m_Entries>', 1)
        with open(path, 'w', encoding='utf-8', newline='\n') as f:
            f.write(text)
    return new


def update_packages(promos=(), works=(), people=()):
    added = []
    added += ensure_xlp_entries('TsoDCE_UILeaders.xlp', [LEADER + '_NEUTRAL', LEADER + '_LOADING_FOREGROUND'])
    added += ensure_xlp_entries('TsoDCE_LeaderFallbacks.xlp', ['FALLBACK_NEUTRAL_' + LEADER])
    ui = ['%s_FOW_%d' % (b, s) for b in UNIT_GLYPHS for s in UNIT_SIZES]
    ui += ['%s_FOW_%d' % (BUILDING_ICON, s) for s in BUILDING_SIZES]
    ui += ['ICON_PROMOTION_TSOD_CE_%s_32' % n for n in promos]
    ui += ['ICON_GREATWORK_TSOD_CE_%s_%d' % (n, s) for n in works for s in GREATWORK_SIZES]
    ui += ['ICON_GREAT_PERSON_INDIVIDUAL_TSOD_CE_%s_%d' % (n, s) for n in people for s in GP_SIZES]
    added += ensure_xlp_entries('TsoDCE_UITextures.xlp', ui)
    return added


# ----------------------------------------------------------------------------- preview
def previews(out, art, fow):
    os.makedirs(out, exist_ok=True)
    src = art['source']
    # 1. setup screen: old cut-out vs new crop, over the setup-screen background
    bgimg = read_dds(os.path.join(TEX_DIR, LEADER + '_BACKGROUND.dds')).convert('RGBA')
    sheet = Image.new('RGBA', (731 * 2 + 20, 1461), (30, 30, 30, 255))
    for i, im in enumerate((src, art['neutral'])):
        bg = bgimg.resize((round(bgimg.width * 1461 / bgimg.height), 1461)).crop((0, 0, 731, 1461))
        bg.alpha_composite(im)
        sheet.alpha_composite(bg, (i * 751, 0))
    sheet.convert('RGB').resize((sheet.width // 2, sheet.height // 2)).save(os.path.join(out, 'neutral_old_vs_new.jpg'), quality=88)
    # 2. diplomacy on a 1920 x 1080 screen: background stretched to fill, fallback's left edge at 0.60 w
    #    (speaking) and 0.667 w (normal diplomacy), vertically centred, as DiplomacyActionView places it
    for mode, fx in (('speaking', 0.60), ('normal', 2 / 3)):
        screen = art['diplo_bg'].resize((1920, 1080)).copy()
        x = int(1920 * fx)
        screen.alpha_composite(art['fallback'].crop((0, 0, 1920 - x, 1024)), (x, 540 - 512))
        screen.convert('RGB').resize((960, 540)).save(os.path.join(out, 'diplomacy_%s.jpg' % mode), quality=88)
    # 3. loading screen: foreground over the loading background
    load = read_dds(os.path.join(TEX_DIR, LEADER + '_LOADING_BACKGROUND.dds')).convert('RGBA')
    load = load.resize((round(load.width * 1461 / load.height), 1461))
    load.alpha_composite(art['neutral'], (120, 0))
    load.convert('RGB').resize((load.width // 2, load.height // 2)).save(os.path.join(out, 'loading_screen.jpg'), quality=88)
    # 4. FOW icons next to the main glyphs, at 256 and the small sizes
    sheet = Image.new('RGBA', (256 * 4 + 30, 256 + 100), (70, 90, 120, 255))
    x = 0
    for base, (icon, sizes) in fow.items():
        sheet.alpha_composite(icon, (x, 0))
        sheet.alpha_composite(sizes[-1], (x + 256, 0))
        sx = x + 8
        for im in sizes[:-1]:
            sheet.alpha_composite(im, (sx, 270))
            sx += im.width + 8
        x += 512 + 30
    sheet.save(os.path.join(out, 'unit_fow_icons.png'))
    # 5. building FOW next to the main icon
    icon, sizes = art['building_fow']
    sheet = Image.new('RGBA', (512 + 20, 256 + 140), (70, 90, 120, 255))
    sheet.alpha_composite(icon, (0, 0))
    sheet.alpha_composite(sizes[-1], (276, 0))
    sx = 8
    for im in sizes[:-1]:
        sheet.alpha_composite(im, (sx, 266))
        sx += im.width + 8
    sheet.save(os.path.join(out, 'building_fow_icon.png'))
    # 6. great person portraits at 256 and the small sizes, inside the Civilopedia's 298 x 295 frame area
    if art['people']:
        items = list(art['people'].items())
        sheet = Image.new('RGBA', (len(items) * 310, 256 + 30), (40, 34, 30, 255))
        for i, (name, im) in enumerate(items):
            sheet.alpha_composite(im, (i * 310 + 20, 15))
        sheet.save(os.path.join(out, 'great_person_portraits.png'))
    # 7. historic moments made here
    for name, im in art['moments'].items():
        im.convert('RGB').save(os.path.join(out, name + '.jpg'), quality=90)
    # 8. user icons: promotions at 32 px and 4x, great works at 256
    if art['user']:
        items = list(art['user'].items())
        sheet = Image.new('RGBA', (len(items) * 266, 256 + 50), (60, 70, 90, 255))
        for i, (name, im) in enumerate(items):
            if im.width == 32:
                sheet.alpha_composite(im.resize((128, 128), Image.NEAREST), (i * 266, 0))
                sheet.alpha_composite(im, (i * 266 + 140, 0))
            else:
                sheet.alpha_composite(im, (i * 266, 0))
        sheet.save(os.path.join(out, 'user_icons.png'))


# ----------------------------------------------------------------------------- main
def main():
    preview = None
    if '--preview' in sys.argv:
        preview = sys.argv[sys.argv.index('--preview') + 1]
    icon_dir = sys.argv[sys.argv.index('--icons') + 1] if '--icons' in sys.argv else ICON_DIR
    os.makedirs(GEN_DIR, exist_ok=True)
    art = portraits()
    fow = fow_icons()
    art['building_fow'] = building_fow()
    art['user'], promos, works = user_icons(icon_dir)
    art['people'] = great_person_portraits(icon_dir)
    art['moments'] = moments()
    people = list(art['people'])
    xml_changed = write_icon_xml(promos, works)
    xml_changed |= write_great_people_xml(people)
    added = update_packages(promos, works, people)
    if preview:
        previews(preview, art, fow)
    print('textures written to', TEX_DIR)
    print('own promotion icons:', ', '.join(promos) or 'none yet', '| own great work icons:', ', '.join(works) or 'none yet')
    waiting = [n for n, _s, _b in GREAT_PEOPLE if n not in art['people']]
    print('great person portraits:', ', '.join(people), '| waiting for images:', ', '.join(waiting) or 'none')
    print('icon XML rewritten:', 'yes' if xml_changed else 'no change')
    print('new XLP entries:', ', '.join(added) if added else 'none')


if __name__ == '__main__':
    main()
