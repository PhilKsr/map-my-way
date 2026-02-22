# Map My Way

Create beautiful animated travel videos from your routes. A TravelBoast-like web application for visualizing and sharing your journeys.

## Tech Stack

- **Frontend**: React 19, Next.js 16 (App Router)
- **Language**: TypeScript with strict configuration
- **UI Library**: Mantine v8
- **Maps**: Leaflet with React-Leaflet
- **State Management**: TanStack Query v5
- **Testing**: Vitest, React Testing Library
- **Code Quality**: ESLint, Prettier, Husky
- **Package Manager**: pnpm

## Getting Started

### Prerequisites

- Node.js 20+
- pnpm

### Installation

```bash
# Clone the repository
git clone <repository-url>
cd map-my-way

# Install dependencies
pnpm install

# Start development server
pnpm dev
```

Open [http://localhost:3000](http://localhost:3000) to view the application.

## Development Scripts

```bash
# Development
pnpm dev              # Start development server
pnpm build            # Build for production
pnpm start            # Start production server

# Code Quality
pnpm lint             # Run ESLint
pnpm lint:fix         # Fix ESLint issues
pnpm format           # Format with Prettier
pnpm format:check     # Check formatting
pnpm type-check       # Run TypeScript checks

# Testing
pnpm test             # Run unit tests
pnpm test:ui          # Run tests with UI
pnpm test:coverage    # Run tests with coverage
```

## Code Quality Standards

This project follows Essencium frontend development standards:

- **TypeScript**: Strict mode with comprehensive type checking
- **ESLint**: Custom configuration with React and TypeScript rules
- **Prettier**: Consistent code formatting with Tailwind CSS plugin
- **Husky**: Git hooks for pre-commit linting and formatting
- **Commitlint**: Conventional commit message format

### Commit Convention

```
type(scope): description

Examples:
feat(map): add route visualization
fix(ui): resolve mobile responsive issues
docs(readme): update installation instructions
```

## Project Structure

```
src/
├── app/              # Next.js App Router pages
├── components/       # Reusable React components
├── lib/             # Utility functions and configurations
├── test/            # Test setup and utilities
└── types/           # TypeScript type definitions
```

## Features (Planned)

- Interactive map for route creation
- Animated travel video generation
- Route sharing and gallery
- Mobile responsive design
- Export functionality
