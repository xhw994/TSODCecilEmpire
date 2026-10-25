"""Generate the Cecil mod's derived textures from the user's art in imgs/.

Run from the repo root:
    python -X utf8 tools/make_art.py [--preview DIR]

Writes src/Textures/<NAME>.dds + <NAME>.tex (uncompressed RGBA DDS, same layout as the other
textures here) and art/generated/<NAME>.png as the editable source, then adds any new texture to
its XLP package. --preview also writes contact sheets to DIR for review.

What it makes:
  Gawain's portraits, from the cut-out imgs/Processed Images/LEADER_TSOD_GAWAIN_CECIL_NEUTRAL.png
    LEADER_TSOD_GAWAIN_CECIL_NEUTRAL             731 x 1461  setup screen
    LEADER_TSOD_GAWAIN_CECIL_LOADING_FOREGROUND  731 x 1461  loading screen (same image, as the base game does)
    FALLBACK_NEUTRAL_LEADER_TSOD_GAWAIN_CECIL    825 x 1024  diplomacy screen, figure in the left 580 px
  Fog-of-war versions of the two unit glyphs, from their current 256 px icons
    ICON_UNIT_TSOD_SCOUT_AMBER_FOW_*, ICON_UNIT_TSOD_GORGON_PLATFORM_FOW_*  (22 32 38 50 80 256)

Everything else in src/Textures is hand-made and left alone. Crops are in source-image pixels;
adjust them here and re-run. Same approach as tools/make_art.py in the Typhon mod.
"""
import os
import re
import struct
import sys

from PIL import Image, ImageChops, ImageFilter

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
# Diplomacy figure: full width, aspect 580 x 1024, head ~7% down.
FALLBACK_BOX = (0, 170, 731, 1461)          # 731 x 1291

# FOW glyph colours (Typhon tools/icon_art.py unit_glyph): gold fill on a dark-brown outline
FOW_FILL = (201, 164, 106, 255)
FOW_EDGE = (52, 38, 24, 255)


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
    fig = feather(crop_resize(src, FALLBACK_BOX, (580, 1024)), 30, 0, 90, 60)
    fallback = Image.new('RGBA', (825, 1024), (0, 0, 0, 0))
    fallback.alpha_composite(fig, (0, 0))
    made['fallback'] = emit(fallback, 'FALLBACK_NEUTRAL_' + LEADER, fallback=True)
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


def update_packages():
    added = []
    added += ensure_xlp_entries('TsoDCE_UILeaders.xlp', [LEADER + '_NEUTRAL', LEADER + '_LOADING_FOREGROUND'])
    added += ensure_xlp_entries('TsoDCE_LeaderFallbacks.xlp', ['FALLBACK_NEUTRAL_' + LEADER])
    added += ensure_xlp_entries('TsoDCE_UITextures.xlp',
                                ['%s_FOW_%d' % (b, s) for b in UNIT_GLYPHS for s in UNIT_SIZES])
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
    # 2. diplomacy: fallback over the diplomacy background
    dip = read_dds(os.path.join(TEX_DIR, LEADER + '_DIPLOMACY_BACKGROUND.dds')).convert('RGBA')
    dip = dip.resize((round(dip.width * 1024 / dip.height), 1024))
    dip.alpha_composite(art['fallback'], (dip.width // 2 - 600, 0))
    dip.convert('RGB').resize((dip.width // 2, dip.height // 2)).save(os.path.join(out, 'diplomacy_fallback.jpg'), quality=88)
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


# ----------------------------------------------------------------------------- main
def main():
    preview = None
    if '--preview' in sys.argv:
        preview = sys.argv[sys.argv.index('--preview') + 1]
    os.makedirs(GEN_DIR, exist_ok=True)
    art = portraits()
    fow = fow_icons()
    added = update_packages()
    if preview:
        previews(preview, art, fow)
    print('textures written to', TEX_DIR)
    print('new XLP entries:', ', '.join(added) if added else 'none')


if __name__ == '__main__':
    main()
