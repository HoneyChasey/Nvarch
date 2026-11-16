# Vim tutorials

Tips and keybindings to get used to Vim motions.

## Moving and selecting words

`w` jumps to the **start** of the next word, and punctuation counts as its own word: in `"salut"`, Vim sees `"`, `salut` and `"`. From the `s`, `w` lands on the closing `"`, not on the `t`.

**Motions**

| Keys | Moves to |
|---|---|
| `w` / `b` | start of the next / previous word |
| `e` / `ge` | end of the next / previous word |
| `W` / `B` / `E` | same, but only spaces separate words (punctuation is ignored) |

**Selecting with text objects**

Put the cursor anywhere inside the word or the quotes; no need to move to the edges first.

| Keys | Selects |
|---|---|
| `viw` | the word (`salut`) |
| `vaw` | the word and the space after it |
| `vi"` | everything inside the quotes (`salut`) |
| `va"` | the quotes included (`"salut"`) |

`vi"` also works when the cursor is before the quotes on the same line: Vim finds the next pair.

The same objects work with an action instead of `v`:

- `ci"` deletes the text inside the quotes and enters insert mode.
- `di"` deletes the text inside the quotes.
- `yi"` copies the text inside the quotes.

They also exist for `'`, `(`, `{`, `[` and HTML tags (`it`, `at`).
