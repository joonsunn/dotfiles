# CSS Layout Patterns

Gotchas and patterns discovered across sessions. Keep entries short, in sentence case.

## Height transitions from `auto`

CSS cannot interpolate between `height: auto` and a concrete value. The transition snaps instead of animating. Use `max-height` with a fixed upper bound (e.g. `max-height: 4rem` to `max-height: 0`) instead. The upper bound should be close to the actual content height to avoid timing mismatches.

## Inline elements ignore height/max-height

Elements with `display: inline` (e.g. `<a>`, `<span>`) do not respond to `height` or `max-height`. Set `display: block` or `display: inline-block` before applying height transitions.

## Scroll-driven margin conflicts with `position: sticky`

Applying `marginTop` (or similar) based on scroll position consumes scroll distance and fights `position: sticky`. The page does not scroll until the animation completes, causing a "scroll delay" feel. Avoid this pattern; use CSS class toggles with transitions instead.

## `position: sticky` stays in flex flow

A sticky element remains a flex item of its container, so a top bar placed inside a row flex container stretches into a side column instead of spanning the top. Use `position: fixed` with content offset, or move the bar outside the flex container.
