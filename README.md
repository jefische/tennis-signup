# tennis-signup

A registration portal for tennis tournaments and leagues. Players sign up for a draw, pay, and track the status of their entry. Organizers review entries and build the draws.

> **Status:** early development. The monorepo, database schema and API skeleton are in place. The features below are the roadmap.

## Planned features

- [ ] Multi-step registration form (draw, rating, doubles partner)
- [ ] Mocked payment step
- [ ] Confirmation email with a magic link to check status or edit an entry
- [ ] Entry status tracking: pending, confirmed, waitlisted, withdrawn
- [ ] Organizer sign-in (Google / OIDC)
- [ ] Organizer dashboard to create tournaments, review entries and generate draws

### Why players don't need accounts

Requiring an account before registering adds friction, and casual players drop off. Authentication is therefore split by role:

- **Players** register without an account. A confirmation email contains a magic link for checking status or editing the entry later.
- **Organizers** sign in with Google or OIDC, because they create tournaments, review entries and manage draws.

Optional player accounts (so returning players don't re-enter their details) can be added later without changing this model.

## Tech stack

| Layer | Tools |
| --- | --- |
| Frontend | React 19, Vite, TypeScript, react-hook-form |
| API | Express 5, TypeScript (run with tsx) |
| Validation | zod schemas shared by frontend and API |
| Database | PostgreSQL 17 (Docker), node-pg-migrate |
| Tooling | pnpm workspaces, ESLint |

## Project structure

```
apps/
  web/        React + Vite frontend (dev server proxies /api to the API)
  api/        Express API
packages/
  shared/     zod schemas and inferred types used by web and api
db/
  migrations/ SQL migrations (node-pg-migrate)
  seed.sql    sample data for local development
```

## Getting started

**Prerequisites:** Node.js, pnpm and Docker.

```bash
pnpm install

# Configure environment
cp .env.example .env

# Start Postgres
docker compose up -d

# Create the schema
pnpm migrate up

# Load sample data
docker compose exec -T db psql -U tennis -d tennis_signup < db/seed.sql

# Run web (http://localhost:5173) and API (http://localhost:3000)
pnpm dev
```

To check that the app is running, open http://localhost:5173/api/health. It should return `{"status":"ok"}`.

## Scripts

Run from the repo root:

| Command | Description |
| --- | --- |
| `pnpm dev` | Start web and API with hot reload |
| `pnpm typecheck` | Type-check all packages |
| `pnpm lint` | Lint all packages |
| `pnpm build` | Production build of the frontend |
| `pnpm migrate up` | Apply pending migrations |
| `pnpm migrate down` | Roll back the last migration |
| `pnpm migrate create <name>` | Create a new migration file |

## Data model

- **tournaments**: name, location and dates
- **draws**: an event within a tournament (singles or doubles, NTRP level 2.0–5.5, size and age limits)
- **players**: contact details, level, birth date; email is unique (case-insensitive)
- **registrations**: a player's entry into a draw, with an optional doubles partner and a status
