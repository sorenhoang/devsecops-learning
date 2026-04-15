# 🧭 DevSecOps Learning Roadmap Tracker

A personal progress tracker for my DevSecOps learning journey — built as a static web app, deployed via GitHub Actions to GitHub Pages, with cross-device sync powered by Supabase.

🔗 **Live app**: https://sorenhoang.github.io/devsecops-learning/

---

## 📊 Roadmap Overview

| Phase | Topic | Duration | Certification |
|-------|-------|----------|---------------|
| 1 | AWS Foundation + Networking | 1.5–2 months | AWS SAA-C03 |
| 2 | Terraform + CI/CD | 2 months | HashiCorp Terraform Associate |
| 3 | Kubernetes | 2 months | CKA / CKAD |
| 4 | Security Foundation | 1.5–2 months | AWS Security Specialty |
| 5 | DevSecOps Integration | 1 month | Capstone Project |
| **Total** | | **7.5–9 months** | |

---

## 🏗️ Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | Vanilla HTML / CSS / JS (single file, no build step) |
| Auth | Supabase Magic Link (email) |
| Database | Supabase PostgreSQL (progress synced across devices) |
| Hosting | GitHub Pages |
| CI/CD | GitHub Actions |

---

## ✨ Features

- **5-phase roadmap** with week-by-week tasks (140+ checkboxes)
- **Progress bars** per phase and overall
- **Cross-device sync** — check a task on laptop, see it on phone
- **localStorage cache** — works offline, syncs when online
- **Magic link auth** — no password required
- **COMPLETE badge** when a phase hits 100%

---

## 🚀 How It Works

```
Push to main
     │
     ▼
GitHub Actions
     │  inject SUPABASE_URL + SUPABASE_ANON_KEY (from GitHub Secrets)
     │  into index.html via sed
     ▼
GitHub Pages
     │  serves static index.html
     ▼
Browser
     │  user signs in via magic link email
     │  checkboxes sync to Supabase in real-time
     ▼
Supabase
     └─ progress table (RLS: each user sees only their own data)
```

---

## 🔧 Local Setup

1. Clone the repo
   ```bash
   git clone https://github.com/sorenhoang/devsecops-learning.git
   cd devsecops-learning
   ```

2. Open `index.html` directly in your browser — the app works with localStorage only (no Supabase needed locally)

---

## ☁️ Deploy Your Own

### 1. Fork this repo

### 2. Create a Supabase project at [supabase.com](https://supabase.com)

### 3. Run the SQL migration

```sql
CREATE TABLE public.progress (
  user_id    UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  data       JSONB NOT NULL DEFAULT '{}',
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.progress ENABLE ROW LEVEL SECURITY;

CREATE POLICY "own_progress" ON public.progress
  FOR ALL USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);
```

### 4. Add GitHub Secrets

Go to **Settings → Secrets → Actions** in your forked repo:

| Secret | Value |
|--------|-------|
| `SUPABASE_URL` | `https://xxxx.supabase.co` |
| `SUPABASE_ANON_KEY` | `eyJhbGci...` (anon key from Supabase Settings → API) |

### 5. Enable GitHub Pages

Go to **Settings → Pages** → Source: **GitHub Actions**

### 6. Push any change to trigger deployment

The workflow injects your credentials at build time — they are never committed to the repo.

---

## 📁 Project Structure

```
devsecops-learning/
├── index.html                  # Tracker app (self-contained)
├── docs/
│   ├── devsecops-roadmap.html              # Original roadmap HTML
│   ├── devsecops-roadmap-implementation.md # Implementation guide
│   └── devsecops-detailed-guideline.md     # Week-by-week plan
└── .github/
    └── workflows/
        └── deploy.yml          # Build + deploy to GitHub Pages
```

---

## 📄 License

MIT
