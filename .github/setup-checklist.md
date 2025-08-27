# Setup Verification Checklist

## Pre-Setup Checklist
- [ ] Node.js installed (v18+)
- [ ] pnpm installed
- [ ] In correct project directory
- [ ] Vite React project initialized

## Critical Steps (Follow in Order)

### 1. Dependencies
- [ ] Install Tailwind v4 dependencies
```bash
pnpm install -D @tailwindcss/vite tailwindcss @tailwindcss/postcss postcss @types/node
```

### 2. 🔥 CRITICAL: Clean CSS First
- [ ] **BEFORE anything else**: Clean `src/index.css`
```bash
echo '@import "tailwindcss";' > src/index.css
```
- [ ] Verify file contains ONLY: `@import "tailwindcss";`

### 3. Configure Files
- [ ] Update `vite.config.ts` with Tailwind plugin and path aliases
- [ ] Update `tsconfig.json` with path aliases
- [ ] Update `tsconfig.app.json` with path aliases

### 4. shadcn/ui Setup
- [ ] Run `pnpm dlx shadcn@latest init`
- [ ] Use these settings:
  - TypeScript: Yes
  - Style: Default
  - Base color: Slate
  - CSS variables: Yes
  - Import alias: @/*
- [ ] Install basic components: `pnpm dlx shadcn@latest add button card input`

### 5. Storybook Setup (Optional)
- [ ] Run `pnpm dlx storybook@latest init`
- [ ] Update `.storybook/main.ts` with Tailwind v4 support
- [ ] Update `.storybook/preview.ts` to import styles
- [ ] Add path aliases to Storybook config

## Verification Tests

### After Setup
- [ ] `pnpm run dev` starts without errors
- [ ] No CSS parsing errors in console
- [ ] Tailwind classes work (test with `className="bg-blue-500"`)
- [ ] shadcn/ui imports work: `import { Button } from "@/components/ui/button"`
- [ ] Button component renders correctly

### Storybook Tests (if installed)
- [ ] `pnpm run storybook` starts without errors
- [ ] Stories load with proper Tailwind styling
- [ ] No import errors for components using `@/` aliases

## Common Issues & Quick Fixes

### CSS Parse Errors
```bash
# If shadcn init fails with CSS errors:
rm components.json
echo '@import "tailwindcss";' > src/index.css
pnpm dlx shadcn@latest init
```

### Import Alias Not Working
```bash
# Restart dev server after config changes
# Ctrl+C then:
pnpm run dev
```

### Storybook Styles Missing
```bash
# Ensure .storybook/preview.ts imports styles:
# import '../src/index.css';
# Then restart Storybook
```

## Quick Test Component

Create this test component to verify everything works:

```tsx
// src/TestComponent.tsx
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"

export function TestComponent() {
  return (
    <div className="p-8 bg-gray-100 min-h-screen">
      <Card className="max-w-md mx-auto">
        <CardHeader>
          <CardTitle className="text-blue-600">Setup Test</CardTitle>
        </CardHeader>
        <CardContent>
          <Button className="w-full mb-4">
            Button Test
          </Button>
          <p className="text-sm text-gray-600">
            If you can see this styled correctly, your setup is working!
          </p>
        </CardContent>
      </Card>
    </div>
  )
}
```

Add to your App.tsx to test:
```tsx
import { TestComponent } from './TestComponent'

function App() {
  return <TestComponent />
}

export default App
```
