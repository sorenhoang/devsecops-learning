#!/bin/bash
# Local dev server — injects Supabase credentials and serves on localhost:8080
# Credentials are read from .env.local (never committed to git)

set -e

# Load .env.local
if [ ! -f .env.local ]; then
  echo "❌ .env.local not found. Copy .env.local.example and fill in your values:"
  echo "   cp .env.local.example .env.local"
  exit 1
fi

export $(grep -v '^#' .env.local | xargs)

if [ -z "$SUPABASE_URL" ] || [ -z "$SUPABASE_ANON_KEY" ]; then
  echo "❌ SUPABASE_URL or SUPABASE_ANON_KEY is empty in .env.local"
  exit 1
fi

# Create temp folder and inject credentials
TMPDIR=$(mktemp -d)
sed "s|__SUPABASE_URL__|${SUPABASE_URL}|g; s|__SUPABASE_ANON_KEY__|${SUPABASE_ANON_KEY}|g" index.html > "$TMPDIR/index.html"

echo "✅ Credentials injected"
echo "🌐 Serving at http://localhost:8080"
echo "   Press Ctrl+C to stop"
echo ""

# Serve
cd "$TMPDIR" && python3 -m http.server 8080 --bind 127.0.0.1
