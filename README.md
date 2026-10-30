# LUXA Salon Finder & Booking Platform

A Flask web application prototype for discovering salons, browsing services, booking appointments, leaving reviews and managing salon listings.

## Project features

- Salon discovery with search and area / price / rating filters.
- Salon detail pages and service listings.
- Session-based sign-in and account flows.
- Appointment booking and customer reviews.
- Admin and salon-management screens.
- Supabase REST API integration for persistence.
- Responsive front-end templates and static assets.

## Technology

- Python 3.10+
- Flask and Gunicorn
- Supabase PostgREST API
- HTML, CSS and JavaScript

## Run locally

1. Create and activate a virtual environment.
2. Install dependencies:

   ```bash
   python -m venv .venv
   # Windows: .venv\\Scripts\\activate
   # macOS/Linux: source .venv/bin/activate
   pip install -r requirements.txt
   ```

3. Copy `.env.example` to `.env` and provide the required values.
4. Start the app:

   ```bash
   python app.py
   ```

   Open `http://127.0.0.1:5000`.

For a production process, use `gunicorn app:app` and configure the environment variables in the host's secret settings.

## Required environment variables

| Variable | Purpose |
|---|---|
| `SECRET_KEY` | Random, private Flask session-signing secret |
| `SUPABASE_URL` | Supabase project URL |
| `SUPABASE_SERVICE_ROLE_KEY` | Server-only key used by the Flask backend |

**Never commit `.env` or expose the service-role key in front-end JavaScript.**

## Database setup

1. Create the Supabase tables using `supabase-schema.sql`.
2. Configure the server-only environment variables.
3. Review and apply `supabase-rls-policies.sql` so the public `anon` and `authenticated` roles cannot directly read or modify user, booking or review records.
4. Configure the same secrets in Vercel / Render before deployment.

The application currently uses a server-side Supabase REST client. Do not replace the service-role key with a browser-visible key while relying on the server's custom session checks.

## Deployment

The repository includes `vercel.json` and a Gunicorn `Procfile`. Add the three environment variables in the hosting provider before deploying.

## Security follow-up required

An earlier commit included a database connection password and a fixed development session secret. Those values have been removed from the current source, but deleting a value from the latest commit does not erase it from Git history. **Rotate the Supabase database password and replace any affected deployment secrets immediately.**

## Development status

This repository is a project prototype. Run through the local setup and test the booking, authentication and admin flows against a non-production Supabase project before using real customer data.
