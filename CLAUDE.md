# CLAUDE.md — Sirah Site Conventions

A guide for any Claude session editing this Arabic Sirah (Prophet's biography) study site. Read this before making changes so you preserve the established voice, structure, and style.

---

## 1. What this site is

A multi-page Arabic study site for the Sirah (السيرة النبوية), drawing primarily on *الرحيق المختوم* by al-Mubarakpuri. Each page is a self-contained HTML file at the repo root (e.g. `mowqe-al-arab.html`, `dar-al-arqam.html`, `index.html`).

- **Language:** Arabic, fully RTL (`dir="rtl"`)
- **Tech:** plain HTML + inline `<style>` + inline `<script>`. No build step. No bundler. No external framework. Leaflet is the only external lib (loaded via CDN).
- **Audience:** Arabic-reading students of the Sirah, looking for clear explanations, visual aids, and self-assessment quizzes.

---

## 2. Writing rules (READ FIRST)

These came from direct user feedback and override your defaults.

### Punctuation

| Don't use | Use instead |
|---|---|
| Em-dash `—` (anywhere) | `:` in headings/titles, `،` for inline pauses, `؛` for stronger pauses, `.` to split sentences, `(...)` for parentheticals |
| `,` (Latin comma) | `،` (Arabic comma) |
| `;` (Latin semicolon) | `؛` (Arabic semicolon) |
| `?` (Latin) | `؟` (Arabic) |
| Three consecutive commas in one clause | Restructure with a colon, period, or rephrase |
| `«حاسة اتجاه»` (calque) | Native Arabic phrasing; avoid English-flavored constructions |

**The em-dash rule is absolute.** Every em-dash in the codebase has been removed and replaced. If you find yourself wanting to use one, use a colon (for definition/elaboration) or restructure the sentence.

### Quotes & Quranic verses

- Quranic verses: wrap in `﴾...﴿` (Arabic ornate brackets)
- Said quotes / emphasized terms: wrap in `«...»` (Arabic guillemets)
- `ﷺ` follows every mention of النبي / محمد
- `عليه السلام` or `ﷺ` follows other prophet names

### Voice & register

- **Literary, not conversational.** Prefer `نخوض في سيرة النبي` over `نتحدث عن النبي`.
- **No meta-commentary about the source author.** Don't write "المباركفوري يبدأ كتابه من هنا..." — let the content stand on its own.
- **Use tashkīl on proper nouns** when first introduced or when ambiguous: `قُصَيّ`, `نِزار`, `كَهْلان`, `طَيِّء`, `كِنْدة`, `جُذام`, `مَذْحِج`, `هَمْدان`, `قَيْدار`, `عَيْلان`.
- **Be concise.** The user prefers terse replies. End-of-turn summaries: 1–2 sentences max.

### Forward connections

When a section foreshadows a later event in the Sirah, use the `.connection` box pattern with a label like "لماذا هذا مهمّ لاحقًا؟" or "رابطٌ محوريّ" or "هذا النظام هو مسرحُ السيرة". Connections are part of the site's pedagogy.

---

## 3. Page architecture: the four-question spine

`mowqe-al-arab.html` is organized as four `<h2>` sections answering:

1. **أوّلًا: مَن هذه القبائل؟** — classifications (بائدة/عاربة/مستعربة), lineages
2. **ثانيًا: أين تسكن؟** — geography, the 5 regions, tribe-region table
3. **ثالثًا: كيف ترتبط القبائل ببعضها؟** — Qahtan/Adnan, migrations, internal Quraysh fault lines
4. **رابعًا: ولماذا كانت مكةُ قلبَ كلِّ شيء؟** — trade, Kaaba, نظام قُصَيّ

Plus: an intro section `لماذا نبدأ بالجغرافيا والقبائل؟`, a summary `الخلاصة في ستّ بطاقات`, and the interactive quiz.

If a new page follows a similar spine pattern, mirror this structure. The 4 quiz sections must align with the 4 content sections.

---

## 4. Design system

### Color tokens (in `:root`)

```css
--navy: #1e3a5f          /* primary text accents, h2 color */
--navy-deep: #0d1b2a     /* hero gradient end */
--gold: #b8860b          /* accent borders, dots, highlights */
--gold-light: #f5e6c8    /* subtle borders, gentler highlights */
--gold-pale: #fdf6e3     /* .insight box background */
--cream: #faf8f2         /* page body background */
--white: #ffffff
--text: #2d3436
--text-light: #636e72
--border: #e8e0d4
```

Use these variables — don't hardcode hex values in new components. If you need a new color (e.g. region polygons), define it inline once with a comment.

### Fonts

- **Amiri** (serif) — h1, h2, h3, h4, decorative labels, names in `.node` and `.saba-node`
- **Tajawal** (sans-serif) — body text, small captions, button text, quiz options

Already loaded via Google Fonts at the top of `<head>`. Don't add more font families.

---

## 5. Reusable components & patterns

### `.insight` box (gold-pale, gold border)

Use for: **definitions**, **clarifications**, **rules of thumb**, **summary callouts**.

```html
<div class="insight">
  <span class="insight-label">ما هي سبأ؟</span>
  <p>...</p>
</div>
```

The `insight-label` is a small gold heading; the body explains.

### `.connection` box (cool gradient, navy border)

Use for: **forward references to later Sirah events**. Pattern signals "this matters because of what's coming."

```html
<div class="connection">
  <span class="connection-label">لماذا هذا مهمّ لاحقًا؟</span>
  <p>...</p>
</div>
```

### Definition box pattern (for unfamiliar names/terms)

When you introduce a key historical name/place that the average reader may not know, **add an `.insight` box** at first mention. Established examples:

- `ما هي سبأ؟` — at top of `هجرات اليمن` section
- `مَن هو قُصَيّ؟` — at top of `نظامُ قُصَيّ` section

The box should include:
1. Title in `insight-label` (the question form: `ما هي X؟` or `مَن هو X؟`)
2. One paragraph explaining: what/who, when, where, why famous
3. Optional `.saba-chain` visual (see below) if a lineage relationship matters
4. Closing paragraph anchoring the term's significance to the page

### `.saba-chain` (visual genealogy / sequence)

Inline horizontal chain of pill-boxes with gold arrows. Used inside `.insight` boxes when showing lineage.

```html
<div class="saba-chain">
  <span class="saba-node">قَحْطان</span>
  <span class="saba-sep">←</span>
  <span class="saba-node">يَعْرُب</span>
  <span class="saba-sep">←</span>
  <span class="saba-node featured">سَبَأ</span>
  <span class="saba-sep">←</span>
  <span class="saba-fork">
    <span class="saba-node">كَهْلان</span>
    <span class="saba-node">حِمْيَر</span>
  </span>
</div>
```

- `.saba-node` — pill-box with name
- `.saba-node.featured` — solid gold (use for the focal name + endpoint)
- `.saba-sep` — the `←` arrow (a Unicode left-arrow renders correctly in RTL: it points toward "next" in reading direction, i.e., the descendant)
- `.saba-fork` — vertical stack of two siblings at end of chain (for "X had two sons: A and B")

### `.card-grid` + `.card`

Grid of mini-cards with `<h4>` + `<p>`. Use for:
- Lists of clans / branches (e.g., the four sons of Nizar, the six clans of Quraysh)
- Summary "خلاصة" cards at end of sections

### `.visual-grid` + `.visual-card`

Like `.card-grid` but with a leading emoji icon. Use for **geographic regions** or other categorical sets where a quick glyph helps recognition. The 5 Arabian regions use this.

### `.flowline` + `.flow-item`

Vertical timeline with gold dots. Use for **sequences of events** (e.g., the four destinations after سيل العَرِم).

### `.tribe-table`

Standard data table with navy header. Use for **reference lookups** (tribe → region → where they appear in the Sirah).

---

## 6. Maps (Leaflet)

The site uses Leaflet + OpenStreetMap for real geographic visualization. Three maps exist:

1. **Kahlan tribes map** (`#tribes-leaflet-map`) — point pins for the 6 Kahlan sub-tribes
2. **Mudar tribes map** (`#mudar-leaflet-map`) — point pins for the 6 Mudar sub-tribes
3. **Five Regions map** (`#regions-leaflet-map`) — colored polygons for the 5 regions

### Setup checklist when adding a new map

1. CSS: add the new map ID to the shared selector (`#tribes-leaflet-map, #mudar-leaflet-map, #regions-leaflet-map, ...`)
2. HTML container:
   ```html
   <div class="tribes-map-wrap">
     <h4>عنوان الخريطة</h4>
     <p class="map-caption">شرح قصير. اضغط على أيّ علامة...</p>
     <div id="your-map-id"></div>
   </div>
   ```
3. JS: append a new IIFE in the script block (NOT inside the existing IIFEs):
   ```js
   <script>
   (function() {
     if (typeof L === 'undefined') return;
     const mapEl = document.getElementById('your-map-id');
     if (!mapEl) return;
     // ... map setup
   })();
   </script>
   ```

### Map conventions

- **Tile source:** OpenStreetMap (`https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png`) with the standard attribution
- **`scrollWheelZoom: false`** — so the user can scroll past without trapping the cursor
- **Reasonable `minZoom`/`maxZoom`** — set per-map based on the area being shown
- **Tribe pins:** gold circles with white Arabic numerals via `.tribe-pin-inner` divIcon
- **Reference city pins:** small navy dots via `.ref-pin-inner` divIcon
- **City labels:** permanent tooltips with `.ref-city-label` class
- **Region tags on cities:** include `region: 'تهامة'` etc. in `refCities` data, render as `<span class="ref-city-region">(...)</span>` so readers can verify which polygon each city belongs to
- **Popup HTML:** `<strong class="tribe-name">name</strong>description` — the strong-tag is styled as a heading by the popup CSS
- **Coordinates are approximate** for historical tribes — note this in the caption when relevant

### Polygon regions specifically

When drawing region polygons, **verify each reference city falls inside the right polygon**. The 5-regions map had a bug where Mecca (39.83°E) fell in a gap between Tihama (ended at 39°E) and Hijaz (started at 40.25°E). Fix:
- Share boundary vertices between adjacent regions (e.g., Tihama-east and Hijaz-west use the same `[21.8, 40.1]`, `[22.5, 39.0]`, `[24.5, 38.5]`)
- Test mentally: at the city's latitude, is the city's longitude inside the polygon?
- Add the region name to the city tooltip as a verification cue: `مكة (تهامة)`

---

## 7. Quiz section

Each chapter page ends with an interactive quiz:

- 4 collapsible sections (matching the 4 spine questions on `mowqe-al-arab.html`, or topical groupings on other pages)
- 5 questions per section, 20 total
- Each question: `t` (title chip), `q` (question), `o` (options array), `a` (index of correct answer)
- Options and questions are **shuffled on every render** — answer indices must stay correct in source
- Arabic numerals: use the helper `toArabicNum(n)` already in the script
- Feedback strings use `.` (period) not `،` (comma) between the two clauses — e.g., `'إجابة غير صحيحة. الصحيحة موضحة بالأخضر.'`

When adding/editing quiz questions, **double-check the answer index `a`**. There was a real bug where Mecca's region question had `a: 1` (الحجاز) instead of the correct `a: 2` (تهامة).

---

## 8. Backups before major restructures

Before any large content rewrite (e.g., restructuring sections, replacing big SVG blocks), copy the file to `local-backup-YYYY-MM-DD/`:

```bash
mkdir -p local-backup-$(date +%Y-%m-%d)
cp filename.html local-backup-$(date +%Y-%m-%d)/filename.before-X.html
```

Tell the user where the backup is.

---

## 9. Workflow conventions

### Editing

- Prefer **Edit** for surgical changes (one section, one paragraph)
- Use **Write** only for whole-file rewrites
- For Arabic content, **read the surrounding context** before editing — line numbers shift between sessions
- After editing, **verify** with `grep` (count occurrences, check structure) and `wc -l` (line count sanity)

### Tools

- **TodoWrite** for any task with 3+ steps
- **AskUserQuestion** when offering design choices — use the `preview` field with ASCII mockups when the choice is visual
- **Bash `git` ops** — never push or force-push without explicit user request; never `git config`; never `--no-verify`

### Responses

- **Be concise.** A short summary of what changed + what's next. No long explanations unless asked.
- **No trailing "let me know if..." filler** unless you genuinely need input
- **Use markdown links** to reference files: `[mowqe-al-arab.html](mowqe-al-arab.html)`, optionally with line: `[mowqe-al-arab.html:42](mowqe-al-arab.html#L42)`

### What NOT to do

- ❌ Don't use em-dashes
- ❌ Don't add meta-commentary about source authors (Mubarakpuri etc.) into prose
- ❌ Don't write code comments that just describe what the code does
- ❌ Don't add backwards-compatibility shims for content changes (just change the code)
- ❌ Don't create new `.md` documentation files unless the user explicitly asks
- ❌ Don't re-attempt an approach the user has already rejected — switch strategy
- ❌ Don't iterate on a feature if the user signals "remove it" — remove it cleanly (both HTML and the CSS that only supports it)
- ❌ Don't add emojis to user-facing content unless they were already in the design (the 5-regions visual cards have emojis because they were part of the original; don't introduce new ones elsewhere)
- ❌ Don't commit, push, or open PRs without an explicit user request

---

## 10. File structure

```
Sirah/
├── index.html                       # site index / landing
├── mowqe-al-arab.html               # موقع العرب وأقوامها (the most developed page; reference implementation)
├── aam-alhuzn.html                  # عام الحزن
├── al-jahr-biddawa.html             # الجهر بالدعوة
├── dar-al-arqam.html                # دار الأرقم
├── hajjat-al-wadaa.html             # حجة الوداع
├── islam-hamza-wa-omar.html         # إسلام حمزة وعمر
├── nasab-alnabi.html                # نسب النبي ﷺ
├── al-mawlid.html                   # المولد
├── ...                              # other chapter pages
├── physiotherapy/                   # unrelated subsite (do not touch unless asked)
├── local-backup-2026-05-18/         # backups from prior sessions
├── push.sh / pull.sh                # git helpers
├── CLAUDE.md                        # this file
└── .claude/                         # Claude Code settings
```

Each chapter page is self-contained: the CSS lives in its own `<style>` block, JS in its own `<script>` blocks. There is no shared stylesheet. **If you change a design token (color, font, spacing), change it everywhere it's used in that file — don't expect cross-file inheritance.**

---

## 11. The 4 maps + 2 definition boxes already on `mowqe-al-arab.html`

For reference when adding similar features to other pages:

| Feature | Location | Pattern |
|---|---|---|
| Five Regions map | inside `أقسام الجزيرة الخمسة` section | Leaflet polygons + city pins with region tags |
| Kahlan tribes map | after Kahlan card grid in `أوّلًا: مَن هذه القبائل؟` | Leaflet point pins + reference cities |
| Mudar tribes map | after Mudar bullet list in `أوّلًا: مَن هذه القبائل؟` | Leaflet point pins + reference cities |
| `ما هي سبأ؟` definition box | top of `هجرات اليمن` h3 | `.insight` + `.saba-chain` (genealogy fork) |
| `مَن هو قُصَيّ؟` definition box | top of `نظامُ قُصَيّ` h3 | `.insight` + `.saba-chain` (lineage to Prophet) |

---

## 12. Quick reference: when the user asks for X

| Request | Default response |
|---|---|
| "Define X" / "Explain X" in the page | Add an `.insight` definition box at first mention, following the سبأ/قُصَيّ pattern |
| "Show on a map" | Add a Leaflet map (real OSM tiles, not stylized SVG) following the existing 3-map pattern |
| "Show the relationship" / "lineage" | Use `.saba-chain` inside an `.insight` box |
| "Improve this paragraph" | Tighten rhythm, drop meta-commentary, prefer native Arabic phrasing, replace any em-dashes, propose a rewrite and ask before applying for non-trivial changes |
| "Restructure the page" | Back up first to `local-backup-YYYY-MM-DD/`, then propose a plan with `AskUserQuestion` before executing |
| "Remove X" | Remove HTML **and** the CSS/JS that only supports it. Don't leave dead code |

---

Last updated: 2026-05-18
