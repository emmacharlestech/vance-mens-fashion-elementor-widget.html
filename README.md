# Top-Notch Shemen Global website

The public website for **Top-Notch Shemen Global**: Top-Notch Wardrobes (men's suits, shoes and accessories) and Top-Notch Venue Concept (stage design and event decoration). It's a single static page (`index.html`) with its images and video, deployed on Vercel.

- **Orders, venue quotes and messages** open WhatsApp with the details filled in. No payment is taken on the site.
- **Products, prices and photos** are built into the page script (`DEFAULT_PRODUCTS`, `VENUE_ALBUMS`).

## Updating

The page is edited in `c:\xampp\htdocs\lp\vance-mens-fashion-elementor-widget.html`. To publish changes:

```
bash tools/sync-from-lp.sh
git add -A && git commit -m "Update site" && git push
```

The sync script copies the page as `index.html`, plus only the images and video it uses. Vercel redeploys automatically on every push to `main`.

## Admin

The admin area (prices, products, albums, reviews, contact details, order inbox) is a separate PHP + MySQL app in `c:\xampp\htdocs\topnotch`. Vercel can't run PHP or MySQL, so this deployment uses the catalogue built into the page.

When the admin is hosted on a PHP server, point `SITE_SETTINGS.adminApi` in the page at it, e.g. `https://example.com/topnotch/api/`. Because that's a different domain, the API will also need to allow requests from the Vercel site (CORS).
