# What the original looked like

Access forms cannot be rendered outside Microsoft Access: the layout of the 60 forms lives in a
proprietary binary inside `openslim-v373b0.mdb` that mdbtools does not decode, the upstream repo
ships no screenshots, and the author's original screenshot post
(`thinkinbig.org/2009/08/16/some-openslim-nmtools-v3-33b0-screenshots/`) survives in the Wayback
Machine only as text — its gallery images were never archived.

So the two files here are **reconstructions, not screenshots**. Everything factual in them is
recovered from the binaries:

- form names and the switchboard targets — the `MSysObjects` catalogue and the `DoCmd.OpenForm`
  calls in the VBA streams (`docs/access_objects.md`);
- field names, tab groupings, combo-box sources and sub-forms — `TblNodes` and the saved queries
  (`docs/access_queries.sql`);
- the chrome (title bar, menu bar, tab control, sunken text boxes, record navigator) — Access
  2003's standard appearance.

Pixel positions are *not* authentic.
