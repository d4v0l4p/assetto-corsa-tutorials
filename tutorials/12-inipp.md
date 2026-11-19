# 12. Advanced configs with INIpp

![Level](https://img.shields.io/badge/level-advanced-cf222e) ![Needs](https://img.shields.io/badge/needs-CSP-e8590c)

`ext_config.ini` is not a plain INI file. CSP reads it with **INIpp**, its own preprocessor that adds includes, variables, expressions and templates. You do not need any of this for a normal car config, but it saves a lot of copy and paste on big ones.

Source: [ac-custom-shaders-patch/inipp](https://github.com/ac-custom-shaders-patch/inipp). The repository also contains a command line version of the preprocessor, so you can see what your file turns into.

## Auto-indexing

You already know this one from earlier tutorials: `...` picks the next free number.

<table>
<tr><th>You write</th><th>CSP reads</th></tr>
<tr><td>

```ini
[SECTION_...]
PROP_... = value 1
PROP_... = value 2

[SECTION_...]
PROP_... = value 3
```

</td><td>

```ini
[SECTION_0]
PROP_0 = value 1
PROP_1 = value 2

[SECTION_1]
PROP_0 = value 3
```

</td></tr>
</table>

## One block for several sections

List section names separated by commas and the values go to all of them:

```ini
[SECTION_0]
KEY = 0

[SECTION_1]
KEY = 1

[SECTION_0, SECTION_1]
KEY_SHARED = VALUE    ; ends up in both
```

## Quotes and long lists

Quotes allow values with `[`, `]`, `;`, `,` or line breaks. A `\` at the end of a line continues a list on the next line:

```ini
[GRASS_FX]
GRASS_MATERIALS = grass, grass_ext, sbancamento, grass_ext_flat, \
  gras_brd_ext, grs-brd

[SECTION]
KEY = "value, with; [special] symbols"
```

## Includes

```ini
[INCLUDE: common/materials_carpaint.ini]
CarPaintMaterial = Carpaint     ; a variable passed to the included file
```

- Each file is only included once, unless you pass different variables.
- A value from an included file can be overwritten later in your own file.

## Variables

Any value can be used as a variable with `$Name` or `${Name}`:

```ini
[DEFAULTS]
GlowColor = 1, 0.4, 0.1

[EMISSIVE_EXTRA_A_...]
NAME = light_bar
COLOR = $GlowColor

[EMISSIVE_EXTRA_B_...]
NAME = grille_lights
COLOR = $GlowColor
```

Change the color in one place and every section follows.

| Form | Result |
|---|---|
| `$Missing` | stays as the text `$Missing` |
| `${Missing}` | becomes empty |
| `${List:count}` | number of items |
| `${List:exists}` | 1 if set, 0 if not |
| `${Value:vec3}` | forced to 3 numbers, for safe math |

> [!IMPORTANT]
> Use CamelCase for your own variables and templates (`GlowColor`, not `GLOW_COLOR`). CSP's own keys are upper case, so this avoids clashes.

## Switching sections off

`ACTIVE = 0` removes a whole section. Combined with variables that gives optional parts:

```ini
[SHADER_REPLACEMENT_...]
ACTIVE = ${OtherMaterials:count}   ; skipped if the variable is not set
MATERIALS = $OtherMaterials
SHADER = ksPerPixelNM
```

## Expressions

A `$` before a quoted string runs it as Lua:

```ini
[DEFAULTS]
LightsIntensity = 2
LightsDirection = 0.5, 0.5, 1

[LIGHT_...]
INTENSITY = $" 2 * $LightsIntensity "
ACTIVE = $" $LightsIntensity > 1 "                     ; true/false become 1/0
DIRECTION = $" ${LightsDirection:vec3}:normalize() "
KEY = $" def($Variable, 10) "                          ; 10 if Variable is not set
```

You can define your own functions with `[FUNCTION: Name]` sections or load them from a Lua file with `[USE: file.lua]`.

## Templates

This is how CSP's `Material_CarPaint` and the other blocks from the [PBR reference](../reference/csp-pbr-materials.ini) work. A template is a section type you define yourself:

```ini
[TEMPLATE: Material_CarPaint]
@OUTPUT = SHADER_REPLACEMENT_0CARPAINT_...   ; what each use turns into
SHADER = smCarPaint
MATERIALS = $CarPaintMaterial

[TEMPLATE: Material_CarPaint_Old EXTENDS Material_CarPaint]
SHADER = smCarPaint_old

[Material_CarPaint_Old]
CarPaintMaterial = CarPaint_EXT

[Material_CarPaint_Old]                      ; same template again, other values
CarPaintMaterial = CarPaint_EXT2
SKINS = some_skin
```

CSP turns that into:

```ini
[SHADER_REPLACEMENT_0CARPAINT_0]
MATERIALS = CarPaint_EXT
SHADER = smCarPaint_old

[SHADER_REPLACEMENT_0CARPAINT_1]
MATERIALS = CarPaint_EXT2
SHADER = smCarPaint_old
SKINS = some_skin
```

That is also why you can write `[Material_CarPaint]` twice in your config: each use becomes its own section.

> [!TIP]
> A practical use: put your templates in a file like `my_templates.ini`, include it in all your cars and keep the car configs short.

INIpp also has **mixins** (template parts that can be switched off with a condition) and **generators** (templates that output several sections). They are mostly used inside CSP's shared files; see the INIpp README if you need them.

---

[← 11. Exhaust flames](11-exhaust-flames.md) · [Index](../README.md) · [13. Lua apps →](13-lua-apps.md)
