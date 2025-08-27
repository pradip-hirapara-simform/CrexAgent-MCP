# Improved React + Vite + Tailwind CSS + shadcn/ui Project Setup Guide

## 🚨 CRITICAL SETUP ORDER - Follow These Steps Exactly

### Step 1: Project Initialization
```bash
pnpm create vite@latest . -- --template react-ts
pnpm install
```

### Step 2: Install Dependencies
```bash
# Install Tailwind CSS v4 and required packages
pnpm install -D @tailwindcss/vite tailwindcss @tailwindcss/postcss postcss @types/node

# Install path dependency for aliases
pnpm install -D @types/node
```

### Step 3: 🔥 CRITICAL - Clean index.css FIRST
**Do this BEFORE any other CSS configuration:**

```bash
# Completely wipe the index.css file
echo '@import "tailwindcss";' > src/index.css
```

**Verify the file only contains:**
```css
@import "tailwindcss";
```

### Step 4: Configure Vite
Update `vite.config.ts`:
```typescript
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'
import path from 'path'

export default defineConfig({
  plugins: [
    react(),
    tailwindcss(),
  ],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
})
```

### Step 5: Configure TypeScript Path Aliases
Update `tsconfig.json`:
```json
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"]
    }
  },
  "files": [],
  "references": [
    { "path": "./tsconfig.app.json" },
    { "path": "./tsconfig.node.json" }
  ]
}
```

Update `tsconfig.app.json`:
```json
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "isolatedModules": true,
    "moduleDetection": "force",
    "noEmit": true,
    "jsx": "react-jsx",
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"]
    }
  },
  "include": ["src"]
}
```

### Step 6: Initialize shadcn/ui
```bash
pnpm dlx shadcn@latest init
```

**Configuration options:**
- TypeScript: Yes
- Style: Default
- Base color: Slate
- CSS variables: Yes
- Tailwind config location: ./tailwind.config.js (leave default)
- Configure import alias: Yes
- Import alias: @/*

### Step 7: Install Basic Components
```bash
# Install commonly used components
pnpm dlx shadcn@latest add button card input
```

### Step 8: Setup Storybook (Optional but Recommended)
```bash
# Initialize Storybook
pnpm dlx storybook@latest init
```

### Step 9: Configure Storybook for Tailwind v4
**Important: Update `.storybook/main.ts` immediately after init:**

```typescript
import type { StorybookConfig } from '@storybook/react-vite';
import path from 'path';

const config: StorybookConfig = {
  stories: ['../src/**/*.stories.@(js|jsx|ts|tsx|mdx)'],
  addons: [
    '@storybook/addon-onboarding',
    '@storybook/addon-essentials',
    '@chromatic-com/storybook',
    '@storybook/addon-interactions',
    '@storybook/addon-a11y',
  ],
  framework: {
    name: '@storybook/react-vite',
    options: {},
  },
  viteFinal: async (config) => {
    // Add path aliases
    config.resolve = config.resolve || {};
    config.resolve.alias = {
      ...config.resolve.alias,
      '@': path.resolve(__dirname, '../src'),
    };
    
    // Add Tailwind CSS v4 support
    const { plugins = [] } = config;
    const tailwindcss = await import('@tailwindcss/vite');
    plugins.push(tailwindcss.default());
    
    return {
      ...config,
      plugins,
    };
  },
};

export default config;
```

**Update `.storybook/preview.ts`:**
```typescript
import type { Preview } from '@storybook/react';
import '../src/index.css'; // Import Tailwind styles

const preview: Preview = {
  parameters: {
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/i,
      },
    },
  },
};

export default preview;
```

### Step 10: Test Everything
```bash
# Test the dev server
pnpm run dev

# Test Storybook (in a new terminal)
pnpm run storybook
```

## 🛠️ Automated Setup Script

Create this script to automate the entire process:

```bash
#!/bin/bash
# save as setup.sh and run with: chmod +x setup.sh && ./setup.sh

echo "🚀 Starting automated React + Vite + Tailwind + shadcn/ui setup..."

# Install dependencies
echo "📦 Installing dependencies..."
pnpm install -D @tailwindcss/vite tailwindcss @tailwindcss/postcss postcss @types/node

# Clean index.css FIRST
echo "🧹 Cleaning index.css..."
echo '@import "tailwindcss";' > src/index.css

# Configure vite.config.ts
echo "⚙️ Configuring Vite..."
cat > vite.config.ts << 'EOF'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'
import path from 'path'

export default defineConfig({
  plugins: [
    react(),
    tailwindcss(),
  ],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
})
EOF

# Update tsconfig files
echo "📝 Updating TypeScript configuration..."
# ... (add the tsconfig updates here)

echo "🎨 Initializing shadcn/ui..."
echo "Please follow the prompts for shadcn/ui initialization..."
pnpm dlx shadcn@latest init

echo "🧩 Installing basic components..."
pnpm dlx shadcn@latest add button card input

echo "📚 Setting up Storybook..."
pnpm dlx storybook@latest init

echo "✅ Setup complete! Run 'pnpm run dev' to start development."
```

## 🔧 Troubleshooting Quick Fixes

### CSS Parse Errors
```bash
# If you get CSS parsing errors during shadcn init:
rm components.json
echo '@import "tailwindcss";' > src/index.css
pnpm dlx shadcn@latest init
```

### Storybook Not Loading Styles
```bash
# Restart Storybook after any config changes:
# Ctrl+C to stop, then:
pnpm run storybook
```

### Path Aliases Not Working
```bash
# Restart dev server after TypeScript config changes:
# Ctrl+C to stop, then:
pnpm run dev
```

## ✅ Verification Checklist

After setup, verify these work:
- [ ] `pnpm run dev` starts without errors
- [ ] Tailwind classes work in components
- [ ] `@/components/ui/button` imports work
- [ ] `pnpm run storybook` loads stories with proper styling
- [ ] No console errors in browser

This improved setup should eliminate the common issues you're experiencing with CSS conflicts and Storybook configuration.
