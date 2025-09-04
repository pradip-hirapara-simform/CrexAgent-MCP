# Complete Setup Process Documentation

This document provides a comprehensive overview of all the processes performed to set up this React + TypeScript + Vite project with shadcn/ui, Tailwind CSS v4, and Figma design token integration.

## 🎯 Project Overview

**Final Result**: A modern React application with Figma design tokens integrated into shadcn/ui components using Tailwind CSS v4's semantic color system.

**Key Technologies**:

- React 19 + TypeScript
- Vite (build tool)
- Tailwind CSS v4 (styling)
- shadcn/ui (component library)
- Figma MCP Server (design token extraction)
- pnpm (package manager)

## 📋 Complete Process Timeline

### 1. Initial Project Setup

**Command**:

```bash
pnpm create vite@latest . -- --template react-ts
pnpm install
```

**What was created**:

- Basic React + TypeScript project structure
- Vite configuration
- Initial ESLint setup

### 2. Tailwind CSS v4 Installation

**Commands**:

```bash
pnpm add tailwindcss @tailwindcss/vite
```

**Key Changes**:

- Cleared `src/index.css` completely (critical step)
- Added `@import "tailwindcss";` to `src/index.css`
- Updated `vite.config.ts` with Tailwind plugin

**Files Modified**:

- `src/index.css` - Completely cleared and started fresh
- `vite.config.ts` - Added Tailwind CSS plugin

### 3. Path Aliases Configuration

**Dependencies**:

```bash
pnpm add clsx tailwind-merge
pnpm add -D @types/node
```

**Files Created/Modified**:

- `src/lib/utils.ts` - Created with `cn()` utility function
- `tsconfig.app.json` - Added baseUrl and paths configuration
- `tsconfig.json` - Added baseUrl and paths for shadcn/ui CLI compatibility
- `vite.config.ts` - Added path resolution for `@/` alias

### 4. shadcn/ui Integration

**Command**:

```bash
pnpm dlx shadcn@latest init --src-dir
```

**Configuration Chosen**:

- Style: new-york
- Base color: neutral
- CSS variables: true
- Components location: `src/components`
- Utils location: `src/lib/utils`

**Components Added**:

```bash
pnpm dlx shadcn@latest add button card
```

**Files Created**:

- `components.json` - shadcn/ui configuration
- `src/components/ui/button.tsx` - Button component
- `src/components/ui/card.tsx` - Card component

### 5. Figma Design Token Extraction

**MCP Server Setup**:

- Configured in `.vscode/mcp.json`
- HTTP endpoint: `http://127.0.0.1:3845/mcp`
- Figma access token configured

**Design Tokens Retrieved**:

```json
{
  "Secondary/Text": "#4D4D4D",
  "Primary/Base/Clementine": "#dd6000",
  "Primary/Clementine": "#DD6000",
  "Primary/Base/Shuttle Gray": "#636466",
  "Primary/Shuttle Gray": "#54565B",
  "Primary/Base/Lochmara": "#0096db",
  "Primary/Lochmara": "#0096DB",
  "Primary/Base/Vida Loca": "#66bc29",
  "Primary/Vida Loca": "#66BC29",
  "Secondary/Buttercup": "#F5B324",
  "Secondary/Ecstasy": "#F68C23",
  "Secondary/Background": "#E6E7E8"
}
```

### 6. Color System Mapping

**Initial Approach**: Created TypeScript constants file
**Final Approach**: Pure CSS variables with shadcn/ui semantic mapping

**Color Mapping Decision**:

- **Primary**: Clementine (#DD6000) - Main brand orange
- **Secondary**: Lochmara (#0096DB) - Secondary blue
- **Accent**: Vida Loca (#66BC29) - Success green
- **Muted**: Secondary Background (#E6E7E8) - Light surfaces

**Files Modified**:

- `src/index.css` - Added Figma color variables and semantic mappings

### 7. Theme System Implementation

**Component Created**: `src/components/theme-provider.tsx`

- Custom React context for theme management
- Support for 'dark', 'light', and 'system' themes
- localStorage persistence
- System preference detection

**Integration**: Added to `src/App.tsx` and `src/main.tsx`

### 8. Code Quality Setup

**ESLint Plugins Installed**:

```bash
pnpm add -D eslint-plugin-react eslint-plugin-react-hooks eslint-plugin-jsx-a11y eslint-plugin-import eslint-plugin-simple-import-sort eslint-plugin-prettier eslint-config-prettier eslint-import-resolver-typescript prettier
```

**Prettier Configuration**: `.prettierrc.json` with consistent formatting rules

**Husky + lint-staged Setup**:

```bash
pnpm add -D husky lint-staged
pnpm dlx husky init
```

**Pre-commit Hook**: Automatic linting and formatting on git commit

### 9. Package.json Scripts

**Development Scripts**:

```json
{
  "dev": "vite",
  "build": "tsc -b && vite build",
  "preview": "vite preview",
  "lint": "eslint .",
  "lint:fix": "eslint . --fix",
  "format": "prettier --write .",
  "format:check": "prettier --check .",
  "type-check": "tsc --noEmit",
  "type-check:watch": "tsc --noEmit --watch"
}
```

### 10. Design System Refinement

**Iterative Changes**:

1. Initially mapped Lochmara as primary
2. **User Request**: Change to Clementine as primary
3. **User Request**: Remove design-tokens.ts, use only shadcn/ui semantic colors
4. Cleaned up unused CSS variables (sidebar, old chart colors)

**Final CSS Structure**:

- Figma design tokens as CSS custom properties
- Semantic color mapping to shadcn/ui system
- Dark mode adaptations
- Chart colors using Figma palette

### 11. Documentation Creation

**Files Created**:

- `docs/design-tokens.md` - Design system usage guide
- `.github/copilot-instructions.md` - AI agent guidance

**Content Covered**:

- Color usage patterns
- Component conventions
- Development workflows
- Figma integration process

### 12. Example Implementation

**Demo App Features**:

- Theme toggle component
- Color showcase with Figma tokens
- Button examples using semantic colors
- Responsive layout with cards

## 🔧 Key Configuration Files

### `src/index.css`

```css
@import "tailwindcss";
@import "tw-animate-css";

@custom-variant dark (&:is(.dark *));

@theme inline {
  /* shadcn/ui color mappings */
  --color-primary: var(--primary);
  /* ... */
}

:root {
  /* Figma Design Tokens */
  --clementine: #dd6000;
  --lochmara: #0096db;
  /* ... */

  /* Semantic Mappings */
  --primary: var(--clementine);
  --secondary: var(--lochmara);
  /* ... */
}

.dark {
  /* Dark mode adaptations */
}
```

### `components.json`

```json
{
  "style": "new-york",
  "tailwind": {
    "css": "src/index.css",
    "cssVariables": true
  },
  "aliases": {
    "components": "@/components",
    "utils": "@/lib/utils"
  }
}
```

### `vite.config.ts`

```typescript
export default defineConfig({
  plugins: [react(), tailwindcss()],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
});
```

## 🎨 Design Token Workflow

### Extraction Process

1. **MCP Server Connection**: Connect to Figma via HTTP endpoint
2. **Variable Retrieval**: Use `mcp_figma-mcp-ser_get_variable_defs` tool
3. **Mapping**: Convert Figma variables to CSS custom properties
4. **Semantic Assignment**: Map to shadcn/ui color system

### Usage Patterns

```tsx
// Semantic colors (recommended)
<Button>Primary (Clementine)</Button>
<Button variant="secondary">Secondary (Lochmara)</Button>
<Button variant="outline">Outline</Button>

// Custom accent usage
<Button className="bg-accent hover:bg-accent/90 text-accent-foreground">
  Accent (Vida Loca)
</Button>
```

## 🚀 Development Workflow

### Daily Development

```bash
pnpm run dev          # Start development server
pnpm run type-check   # TypeScript validation
pnpm run lint:fix     # Fix linting issues
pnpm run format       # Format code
```

### Adding Components

```bash
pnpm dlx shadcn@latest add [component-name]
```

### Design Token Updates

1. Extract new variables from Figma
2. Update CSS custom properties in `src/index.css`
3. Test in both light and dark modes
4. Update documentation if needed

## 🔄 Lessons Learned

### Critical Decisions Made

1. **Clementine as Primary**: User preference override for brand color
2. **Pure CSS Approach**: Simplified over TypeScript constants
3. **Semantic Color System**: Better maintainability and component compatibility
4. **pnpm Over npm**: Faster package management
5. **Tailwind v4**: Modern approach with `@theme inline`

### Common Pitfalls Avoided

1. **Don't edit shadcn/ui components directly** - They get overwritten
2. **Clear index.css completely** before Tailwind setup
3. **Use path aliases consistently** - `@/` prefix for all imports
4. **ESLint React refresh warnings** - Normal for utility exports
5. **CSS variable naming** - Follow shadcn/ui conventions

## 📊 Final Project Structure

```
CrexAgent MCP/
├── .github/
│   ├── copilot-instructions.md    # AI agent guidance
│   └── shadcn-setup.prompt.md     # Original setup guide
├── .vscode/
│   ├── mcp.json                   # Figma MCP server config
│   └── settings.json              # VS Code settings
├── docs/
│   └── design-tokens.md           # Design system docs
├── src/
│   ├── components/
│   │   ├── ui/                    # shadcn/ui components
│   │   └── theme-provider.tsx     # Custom theme context
│   ├── lib/
│   │   └── utils.ts               # Utility functions
│   ├── App.tsx                    # Demo application
│   ├── main.tsx                   # App entry point
│   └── index.css                  # Tailwind + design tokens
├── components.json                # shadcn/ui configuration
├── vite.config.ts                # Build configuration
└── package.json                  # Dependencies and scripts
```

## 🎯 Next Steps & Maintenance

### Regular Maintenance

1. **Update Figma tokens** when design system changes
2. **Add new shadcn/ui components** as needed
3. **Test dark mode** with any color changes
4. **Update documentation** when adding new patterns

### Potential Enhancements

1. **Figma Dev Mode access** for automated token sync
2. **Additional shadcn/ui components** (dialog, input, etc.)
3. **Storybook integration** for component documentation
4. **Testing setup** with Vitest or Jest
5. **CI/CD pipeline** for automated deployment

---

**Created**: September 4, 2025  
**Total Setup Time**: Comprehensive multi-step process  
**Final Commit**: `19aa2f4` - "init commit"
