-- CivicLens / LUXA Salon app: deny direct public table access.
-- The Flask server uses SUPABASE_SERVICE_ROLE_KEY from its environment.
-- Service-role credentials must never be committed or sent to the browser.

ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE salons ENABLE ROW LEVEL SECURITY;
ALTER TABLE services ENABLE ROW LEVEL SECURITY;
ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE reviews ENABLE ROW LEVEL SECURITY;

-- Remove the permissive policies used by the earlier prototype.
DROP POLICY IF EXISTS "Allow public read on salons" ON salons;
DROP POLICY IF EXISTS "Allow anon insert on salons" ON salons;
DROP POLICY IF EXISTS "Allow anon update on salons" ON salons;
DROP POLICY IF EXISTS "Allow anon delete on salons" ON salons;

DROP POLICY IF EXISTS "Allow public read on services" ON services;
DROP POLICY IF EXISTS "Allow anon insert on services" ON services;
DROP POLICY IF EXISTS "Allow anon update on services" ON services;
DROP POLICY IF EXISTS "Allow anon delete on services" ON services;

DROP POLICY IF EXISTS "Allow public read on users" ON users;
DROP POLICY IF EXISTS "Allow anon insert on users" ON users;
DROP POLICY IF EXISTS "Allow anon update on users" ON users;

DROP POLICY IF EXISTS "Allow public read on bookings" ON bookings;
DROP POLICY IF EXISTS "Allow anon insert on bookings" ON bookings;
DROP POLICY IF EXISTS "Allow anon update on bookings" ON bookings;
DROP POLICY IF EXISTS "Allow anon delete on bookings" ON bookings;

DROP POLICY IF EXISTS "Allow public read on reviews" ON reviews;
DROP POLICY IF EXISTS "Allow anon insert on reviews" ON reviews;

-- With RLS enabled and no policies for anon/authenticated, direct API access is denied.
REVOKE ALL ON TABLE users, salons, services, bookings, reviews FROM anon, authenticated;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA public FROM anon, authenticated;

-- The trusted Flask server uses the service_role key, stored only as an environment secret.
GRANT ALL ON TABLE users, salons, services, bookings, reviews TO service_role;
GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA public TO service_role;

-- IMPORTANT:
-- 1. Rotate the database password previously committed in the repository history.
-- 2. Set SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY and SECRET_KEY in the hosting provider.
-- 3. Run this SQL only after the server-side service-role environment variable is configured.
