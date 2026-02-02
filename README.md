# Mission Control

A real-time, high-performance dashboard for managing autonomous agents and complex task queues. Built with **Convex**, **React**, and **Tailwind CSS**, Mission Control provides a "Command Center" experience for monitoring and orchestrating operations.

## ✨ Features

- 🚀 **Real-time Synchronization**: Powered by Convex, every change (task moves, agent updates, comments) propagates instantly to all connected clients.
- 🤖 **Agent Oversight**: Monitor the status and activity of your agent roster (Jarvis, Friday, Shuri, etc.) in real-time.
- 📦 **Mission Queue**: A kanban-style overview of tasks categorized by status: Inbox, Assigned, In Progress, Review, and Done.
- 📡 **Live Activity Feed**: A streaming log of all operational events, comments, and status changes.
- 🔐 **Secure Access**: Integrated Convex Auth for secure terminal login and management.
- 📱 **Responsive Design**: Premium, centered layout that works seamlessly across all devices.

## 🛠 Tech Stack

- **Backend**: [Convex](https://convex.dev/) (Real-time Database, Functions, Auth)
- **Frontend**: [React](https://react.dev/) with [Vite](https://vitejs.dev/)
- **Styling**: [Tailwind CSS](https://tailwindcss.com/)
- **Icons**: [Tabler Icons](https://tabler-icons.io/)

## 🚀 Getting Started

### 1. Initial Setup
Run the following commands to install dependencies and start the development environment:

```bash
bun install
bun dev
```

### 2. Seeding Data
To populate your local dashboard with the initial roster of agents and tasks, run the seed script:

```bash
npx convex run seed:run
```

### 3. Terminal Access
1. Open the app in your browser (usually `http://localhost:5173`).
2. Use the **Sign Up** flow to create your commander credentials.
3. Access the dashboard to start monitoring operations.

## 🚢 Deploying to k3s with Flux (Kustomize)

This repo is a Vite + React frontend backed by **Convex**.

Important: the frontend needs `VITE_CONVEX_URL` at **build time**. The included `Dockerfile` builds the app at container startup so `VITE_CONVEX_URL` can be injected via Kubernetes `ConfigMap`/`Secret`.

### Prereqs

1. A Convex deployment (cloud) created via `convex dev` / `convex deploy`.
2. The Convex deployment URL (looks like `https://<team>-<project>.convex.cloud`).
3. Convex Auth config: `convex/auth.config.ts` expects `CONVEX_SITE_URL` to be set in your **Convex** environment (not Kubernetes). Set it to your public site URL (your ingress URL), so auth callbacks work.

### Manifests

Kustomize manifests live here:

- `deploy/k8s/base` (generic)
- `deploy/k8s/overlays/homelab` (example overlay)

Edit the overlay and set:

- `VITE_CONVEX_URL`
- Ingress host (or disable ingress if you use a different exposure method)

### Flux example

In your homelab GitOps repo, create a Flux `Kustomization` pointing at the overlay path.
For example:

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: mission-control
  namespace: flux-system
spec:
  interval: 10m
  path: ./apps/mission-control/deploy/k8s/overlays/homelab
  prune: true
  sourceRef:
    kind: GitRepository
    name: homelab
  wait: true
```

You’ll also need to build/push an image (default referenced image is `ghcr.io/figitaki/openclaw-mission-control:latest`) or change `spec.template.spec.containers[0].image` to match your registry.

## 📖 Learn More

- [Convex Documentation](https://docs.convex.dev/)
- [React Documentation](https://react.dev/)
- [Tailwind CSS Docs](https://tailwindcss.com/)

---

*Mission Control // Secure Terminal Access // Ref: 2026*

