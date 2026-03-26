# Cursor Self-Hosted Cloud Worker

A self-hosted [Cursor cloud agent worker](https://cursor.com/docs/cloud-agent/self-hosted) deployed to Render.com.

## Prerequisites

- A Cursor team plan with "Allow Self-Hosted Agents" enabled
- A service account API key from the Cursor dashboard

## Setup

1. Deploy to Render using the included `render.yaml` blueprint
2. Set the required environment variables in the Render dashboard (see below)
3. Verify the worker appears in your Cursor Cloud Agents dashboard

## Environment Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `CURSOR_API_KEY` | Yes | Service account API key from Cursor dashboard |
| `CURSOR_REPO_URL` | Yes | Target repository URL (e.g. `https://github.com/org/repo`) |
| `GIT_TOKEN` | Recommended | GitHub personal access token for repo read-write access |
| `CURSOR_SINGLE_USE` | No | Set to `true` for ephemeral workers that exit after one session |
| `CURSOR_IDLE_TIMEOUT` | No | Seconds to wait after session ends before exiting (use with single-use) |
| `CURSOR_LABELS` | No | Space-separated labels for worker routing (e.g. `env=production region=us-west`) |

## Health Checks

The worker exposes management endpoints on port 10000:
- `GET /healthz` — Health status
- `GET /readyz` — Readiness check
- `GET /metrics` — Prometheus metrics (includes `cursor_private_worker_bridge_connected` gauge)

## Limitations

Self-hosted workers currently do not support: automations, computer use, artifacts, or multi-repo.
