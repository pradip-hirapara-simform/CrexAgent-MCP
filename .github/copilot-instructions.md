# Copilot Instructions

This is a **React + TypeScript + Vite** project with **shadcn/ui** and **Tailwind CSS v4**, featuring **Figma design token integration** via MCP server.

## Architecture Overview

- **Design System**: shadcn/ui components with Figma-sourced color tokens mapped to semantic CSS variables
- **Styling**: Tailwind CSS v4 with `@theme inline` configuration in `src/index.css`
- **Build Tool**: Vite with path aliases (`@/` → `src/`)
- **Package Manager**: pnpm (use `pnpm` not `npm`)
- **External Integration**: Figma MCP server for design token extraction

## Key Design Patterns

### Color Token Architecture

- **Figma Variables** → **CSS Custom Properties** → **shadcn/ui Semantic Colors**
- Primary color: Clementine (`#DD6000`), Secondary: Lochmara (`#0096DB`), Accent: Vida Loca (`#66BC29`)
- Always use semantic classes: `bg-primary`, `text-secondary`, `bg-accent` (not direct hex values)
- Colors defined in `src/index.css` `:root` and `.dark` sections

### Component Structure

- **UI Components**: `src/components/ui/` (shadcn/ui generated, don't edit manually)
- **Custom Components**: `src/components/` (like `theme-provider.tsx`)
- **Utilities**: `src/lib/utils.ts` contains `cn()` function for conditional classes

### Theme System

- Uses custom `ThemeProvider` context for dark/light mode switching
- Theme state managed in localStorage with system preference detection
- Dark mode classes applied via `document.documentElement.classList`

## Critical Workflows

### Adding shadcn/ui Components

```bash
pnpm dlx shadcn@latest add button card dialog
```

### Development

```bash
pnpm run dev          # Start dev server
pnpm run type-check   # TypeScript validation
pnpm run lint:fix     # Auto-fix linting issues
pnpm run format       # Prettier formatting
```

### Figma Integration

- Use `mcp_figma-mcp-ser_get_variable_defs` tool to extract design tokens
- Update color mappings in `src/index.css` `:root` and `.dark` sections
- Figma server configured in `.vscode/mcp.json`

## Project-Specific Conventions

- **Import Aliases**: Always use `@/` prefix (`import { Button } from "@/components/ui/button"`)
- **Color Usage**: Use semantic color classes, avoid custom hex values in components
- **Component Props**: Use `className` prop with `cn()` utility for conditional styling
- **Dark Mode**: Components automatically adapt via CSS variables, no manual dark: prefixes needed
- **File Organization**: Follow shadcn/ui structure - UI components separate from business logic

## Configuration Files

- `components.json`: shadcn/ui configuration with path aliases
- `src/index.css`: Tailwind v4 theme with Figma color mappings
- `vite.config.ts`: Vite setup with Tailwind plugin and path resolution
- `.husky/pre-commit`: Runs lint-staged for code quality

## Integration Points

- **Figma MCP Server**: HTTP endpoint at `localhost:3845/mcp` for design token extraction
- **shadcn/ui Registry**: Components auto-installed with proper TypeScript types
- **Tailwind CSS v4**: Modern `@theme inline` syntax instead of config files
- **Theme Context**: Centralized dark/light mode state across all components
