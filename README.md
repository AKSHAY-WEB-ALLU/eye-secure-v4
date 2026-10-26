# EYE SECURE V4 — independent app project

This is a code-based React PWA starter for the EYE SECURE shared quotation/billing app. It does **not** use Lovable.

## What is implemented in the source
- Responsive dashboard, quotations/bills, customers, products, settings and dark mode.
- Email/password Supabase sign-in/sign-up.
- Shared customer, product and document tables.
- Shared CRUD policies for authenticated users: any signed-in user can read, add, edit and delete shared business records.
- Realtime refresh listeners for shared records.
- Quotation/bill calculations (items, installation, fixed/percentage discount, GST).
- Print dialog to print or save a document as PDF.
- PWA manifest.
- No real bank details or customer sample data seeded.

## Setup (required before it can be used online)
1. Install Node.js LTS.
2. Create a Supabase project at https://supabase.com/dashboard.
3. In Supabase SQL Editor, run `supabase/schema.sql`.
4. In Supabase Authentication settings, configure your site URL and allowed redirect URLs for your deployment domain.
5. Copy `.env.example` to `.env` and fill in `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY` (the publishable/anon client key only). Never put the service-role/secret key in frontend code.
6. Run:
   ```bash
   npm install
   npm run dev
   ```
7. Test `npm run build`.
8. Push this folder to your own GitHub repository and connect the repo to a static host such as Cloudflare Pages, Netlify, or Vercel. Set the same two environment variables in the host's settings and deploy.

## Mobile app
This is a responsive installable PWA shell. For Android/iOS store packages, add Capacitor after the web build and configure native signing:
- `npm install @capacitor/core @capacitor/cli`
- `npx cap init "EYE SECURE" "com.akshaysoftwares.eyesecure"`
- `npm install @capacitor/android @capacitor/ios`
- `npm run build`
- `npx cap add android` (Android SDK/Android Studio required)
- `npx cap add ios` (requires macOS and Xcode)
- `npx cap sync`
Native app signing and store publication are separate steps. iOS App Store distribution requires Apple developer setup.

## Shared-record access warning
Per your requirement, **every authenticated account has equal read/write/delete access to all customers, products, quotations and bills**. This means any registered user can change or delete any record, including by accident or maliciously. Do not store secrets or private data in the shared tables. Authenticated-only access is enforced by RLS; anonymous visitors cannot access business records.

## Known limitations to resolve before production
- No admin role, audit log, soft-delete/recovery, or rate limiting.
- Document numbering is generated client-side and can collide if multiple users create records simultaneously. Implement a database sequence/RPC before real business use.
- This build's document print view uses browser print-to-PDF rather than a generated PDF file.
- Product catalogue exists, but item rows are currently manually entered; product picker/autofill should be added.
- The PWA manifest does not yet include production icon assets/service-worker offline support.
- Validate with your actual Supabase project and hosting provider before relying on it for business records.
