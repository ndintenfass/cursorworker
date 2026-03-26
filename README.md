# Cursor Self-Hosted Cloud Worker

A self-hosted [Cursor cloud agent worker](https://cursor.com/docs/cloud-agent/self-hosted) deployed to Render.com.

## Setup

1. Deploy to Render using the included `render.yaml` blueprint
2. Set the `CURSOR_API_KEY` environment variable in the Render dashboard
3. Enable "Allow Self-Hosted Agents" in your Cursor Cloud Agents dashboard

## Health Checks

The worker exposes management endpoints on port 8080:
- `GET /healthz` — Health status
- `GET /readyz` — Readiness check
- `GET /metrics` — Prometheus metrics
