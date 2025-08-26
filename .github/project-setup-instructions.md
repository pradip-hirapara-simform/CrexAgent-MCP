# Automation Configuration

**This guide includes automatic setup flags for automation tools.**

## Automation Usage Instructions

To run ALL optional steps automatically without confirmation prompts, set the environment variable:
```bash
export RUN_ALL_OPTIONAL_STEPS=true
```

When `RUN_ALL_OPTIONAL_STEPS=true`, the following will be automatically executed:
- Storybook initialization and configuration
- ESLint and Prettier installation and setup
- Environment variables file creation
- VS Code extensions installation (if using VS Code automation)

## Core Setup (Always Required)
The following core steps are always executed:
1. Vite + React + TypeScript project initialization
2. Tailwind CSS v4 installation and configuration
3. TypeScript path aliases setup
4. shadcn/ui initialization
5. Basic Button, Card, Input components installation

**If you are using an automation tool or script to follow this setup guide, make sure to read the entire file from start to finish.**

Some advanced steps, troubleshooting, and optional configurations (like Storybook, ESLint, Prettier, and environment variables) are described in later sections. For a complete and error-free setup, do not stop at the initial setup steps—process the full markdown file.

# React + Vite + Tailwind CSS + shadcn/ui Project Setup Guide

## Overview
This guide provides step-by-step instructions for setting up a modern React application using Vite as the build tool, Tailwind CSS for styling, and shadcn/ui for UI components.

## Prerequisites
- Node.js (version 18 or higher)
- pnpm or yarn package manager
- Git (optional but recommended)

## 1. Project Initialization

### Create a new Vite React project
```bash
pnpm create vite@latest . -- --template react
pnpm install
```
-- use already opened Folder
### Alternative with yarn
```bash
yarn create vite . --template react
yarn install
```

## 2. Tailwind CSS v4.0 Setup

### Install Tailwind CSS v4.0 Vite plugin
```bash
pnpm install -D @tailwindcss/vite tailwindcss @tailwindcss/postcss postcss

```

### Configure `vite.config.js` with Tailwind plugin
Update your `vite.config.js`:
```javascript
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


**Important:** ### Update `src/index.css`
 Completely remove ALL contents of `src/index.css` add only only:
```css
@import "tailwindcss";
```

**Critical Step:** Delete everything in the file first, then add only the single line above. Do not leave any existing CSS rules from the default Vite template (like body styles, button styles, etc.), as they will cause syntax errors during shadcn/ui initialization and may override Tailwind styles.

**After shadcn/ui initialization:** The file will be automatically updated with CSS custom properties and theme variables. Keep only the Tailwind-related styles and remove any default Vite CSS like:
- `body` styles with `display: flex`, `place-items: center`, etc.
- `button` styles with custom backgrounds and borders
- `a` link styles
- `h1` font-size rules
- Media queries for light/dark themes that aren't Tailwind-related

**Note:** Tailwind CSS v4.0 uses `@import "tailwindcss"` instead of the old `@tailwind` directives. No separate `tailwind.config.js` or `postcss.config.js` files are needed!

---

### ⚠️ Critical Note: shadcn/ui CSS Initialization Error


**Problem:**  
If you run `shadcn@latest init` and see an error like  
`<css input>:9:1: Unexpected }`  
or any CSS parsing error, it means your `src/index.css` still contains leftover styles from the Vite template or other invalid CSS.

**Solution:**  
- Before running `shadcn@latest init`, make sure `src/index.css` contains ONLY this line:
  ```css
  @import "tailwindcss";
  ```

**If you already ran the init and it failed:**
1. Open `src/index.css` and remove everything except `@import "tailwindcss";`
2. Delete the `components.json` file if it was created.

**After successful init:**  
shadcn/ui will add its own CSS variables and theme definitions to `src/index.css`.  
You can then safely keep those, but do not re-add any default Vite CSS.

---

**Important for Node ESM projects:**
If your `package.json` contains `"type": "module"`, you must use `postcss.config.cjs` (not `postcss.config.js`) for your PostCSS config. Using `.js` will cause the error:

```
Failed to load PostCSS config: [ReferenceError] module is not defined in ES module scope
```

**Solution:**
- Delete any `postcss.config.cjs` file if present.
- Create your config as `postcss.config.js` with:
  ```js
  export default {
  plugins: {
    "@tailwindcss/postcss": {},
  }
}
  ```

This ensures compatibility with ESM projects and prevents the error above.

## 3. TypeScript Configuration for Path Aliases

### Update `tsconfig.json`
The default Vite TypeScript project creates a minimal `tsconfig.json`. You need to add path alias configuration:

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

### Update `tsconfig.app.json`
Also add the path aliases to `tsconfig.app.json` for proper TypeScript resolution:

```json
{
  "compilerOptions": {
    // ...existing options...
    
    /* Path aliases */
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"]
    }
  },
  "include": ["src"]
}
```

This ensures shadcn/ui can resolve the `@/` import alias properly in both development and build processes.


### Install path dependency for aliases
```bash
pnpm install -D @types/node
```
 
## 4. shadcn/ui Setup

### Install shadcn/ui CLI
```bash
# If you encounter errors during initialization, remove components.json first:
# rm components.json

pnpm dlx shadcn@latest init
```



**Troubleshooting:** If the CLI fails with CSS parsing errors, ensure `src/index.css` contains ONLY `@import "tailwindcss";` with no other CSS rules from the default Vite template. Remove any default styles like body, button, or link styles that Vite creates automatically.

### Configuration Options
When prompted, choose the following options:
- **TypeScript**: Yes (recommended) or No
- **Style**: Default
- **Base color**: Slate (or your preference)
- **CSS variables**: Yes
- **Tailwind config location**: ./tailwind.config.js
- **Configure import alias**: Yes
- **Import alias**: @/*



**Note:** The Vite config is already updated above with both Tailwind and path aliases.
 
```

## 5. Project Structure

Your project structure should look like this:
```
my-app/
├── src/
│   ├── components/
│   │   └── ui/          # shadcn/ui components will go here
│   ├── lib/
│   │   └── utils.ts     # Utility functions
│   ├── App.tsx
│   ├── main.tsx
│   └── index.css
├── public/
├── package.json
├── vite.config.ts       # Updated with Tailwind v4 plugin
├── tsconfig.json        # Updated with path aliases
└── components.json      # shadcn/ui configuration
```

## 6. Installing shadcn/ui Components

### Add individual components as needed
```bash
# Example: Add Button component
pnpm dlx shadcn@latest add button

# Example: Add Card component
pnpm dlx shadcn@latest add card

# Example: Add Input component
pnpm dlx shadcn@latest add input
```

### Available components
Common components you might want to add:
- `button` - Button component
- `input` - Input field 

## 7. Example Usage

### Basic App.tsx with shadcn/ui components
```tsx
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"

function App() {
  return (
    <div className="min-h-screen bg-gray-50 py-8">
      <div className="container mx-auto px-4">
        <h1 className="text-4xl font-bold text-center mb-8">
          Welcome to React + Vite + Tailwind + shadcn/ui
        </h1>
        
        <Card className="max-w-md mx-auto">
          <CardHeader>
            <CardTitle>Getting Started</CardTitle>
            <CardDescription>
              Your modern React application is ready!
            </CardDescription>
          </CardHeader>
          <CardContent>
            <Button className="w-full">
              Click me!
            </Button>
          </CardContent>
        </Card>
      </div>
    </div>
  )
}

export default App
```

## 8. Development Commands

### Start development server
```bash
pnpm run dev
# or
yarn dev
```

### Build for production
```bash
pnpm run build
# or
yarn build
```

### Preview production build
```bash
pnpm run preview
# or
yarn preview
```

## 9. Useful Scripts to Add

Add these scripts to your `package.json`:
```json
{
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview",
    "lint": "eslint src --ext js,jsx,ts,tsx --report-unused-disable-directives --max-warnings 0",
    "add-component": "pnpm dlx shadcn@latest add",
    "storybook": "storybook dev -p 6006",
    "build-storybook": "storybook build"
  }
}
```

## 10. Setup Storybook (AUTO_RUN if RUN_ALL_OPTIONAL_STEPS=true)

Storybook is a tool for building UI components in isolation. It helps you document and test your components independently.

### 1. Initialize Storybook
```bash
pnpm dlx storybook@latest init
```

**Note:** Storybook will automatically detect your project setup and configure itself for React + Vite.

### 2. Configure Storybook for Tailwind v4

Update `.storybook/main.ts`:
```typescript
import type { StorybookConfig } from '@storybook/react-vite';

const config: StorybookConfig = {
  stories: ['../src/**/*.stories.@(js|jsx|ts|tsx|mdx)'],
  addons: [
    '@storybook/addon-onboarding',
    '@storybook/addon-essentials',
    '@chromatic-com/storybook',
    '@storybook/addon-interactions',
  ],
  framework: {
    name: '@storybook/react-vite',
    options: {},
  },
  viteFinal: async (config) => {
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

### 3. Configure Storybook Preview

Update `.storybook/preview.ts`:
```typescript
import type { Preview } from '@storybook/react';
import '../src/index.css'; // Import your Tailwind styles

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

### 4. Create Your First Story

Create a story for the Button component at `src/components/ui/button.stories.tsx`:


### 6. Run Storybook

```bash
pnpm run storybook
```

Your Storybook will be available at `http://localhost:6006` with your component stories.

### 7. Remove Default Stories (Optional)

If you want to remove the default example stories:
```bash
rm -rf src/stories
```

### 8. Storybook Troubleshooting

**Tailwind styles not loading in Storybook:**
- Ensure `.storybook/preview.ts` imports your `../src/index.css`
- Verify that the Tailwind plugin is added to Storybook's Vite config in `.storybook/main.ts`
- Restart Storybook after configuration changes

**Import alias not working in stories:**
- The Vite configuration with path aliases should work automatically
- If issues persist, you can add path alias support in `.storybook/main.ts`:
```typescript
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
```

## 11. Additional Recommendations (AUTO_RUN if RUN_ALL_OPTIONAL_STEPS=true)

### ESLint and Prettier Setup (AUTO_RUN if RUN_ALL_OPTIONAL_STEPS=true)
```bash
# Install ESLint and Prettier
pnpm install -D eslint prettier eslint-config-prettier eslint-plugin-prettier

# Install React-specific ESLint rules
pnpm install -D eslint-plugin-react eslint-plugin-react-hooks
```

### Helpful VS Code Extensions (AUTO_INSTALL if RUN_ALL_OPTIONAL_STEPS=true)
- ES7+ React/Redux/React-Native snippets
- Tailwind CSS IntelliSense
- Auto Rename Tag
- Bracket Pair Colorizer
- Prettier - Code formatter

### Environment Variables (AUTO_CREATE if RUN_ALL_OPTIONAL_STEPS=true)
Create a `.env` file in your project root:
```
VITE_API_URL=http://localhost:3000
VITE_APP_NAME=My React App
```

Access in your code:
```javascript
const apiUrl = import.meta.env.VITE_API_URL
```

## 12. Troubleshooting

### Common Issues and Solutions

**Vite config import error for Tailwind:**
- Use `import tailwindcss from '@tailwindcss/vite'` NOT `import tailwindcss from 'vite-plugin-tailwindcss'`
- Ensure you installed `@tailwindcss/vite` package, not the old `vite-plugin-tailwindcss`

**Import alias not working:**
- Ensure `vite.config.ts` is properly configured with path aliases
- Ensure `tsconfig.json` has the correct `baseUrl` and `paths` configuration
- Restart the development server after changes

**Tailwind styles not applying:**
- Check that you have ONLY `@import "tailwindcss";` in your CSS file (Tailwind v4.0 syntax)
- Ensure the `@tailwindcss/vite` plugin is added to your Vite config
- Restart the development server

**shadcn/ui components not found:**
- Make sure you've run `pnpm dlx shadcn@latest add [component-name]`
- Check that the import path uses the `@/` alias
- Verify `tsconfig.json` has proper path alias configuration

**shadcn/ui initialization fails with CSS errors:**
- Ensure `src/index.css` contains ONLY `@import "tailwindcss";` before running `shadcn init`
- Remove ALL default Vite CSS including body styles, button styles, link styles, and media queries
- If components.json exists and causes conflicts, remove it and re-run init

**Existing CSS conflicts after shadcn init:**
- After shadcn init, keep only Tailwind-related CSS variables and theme definitions
- Remove any remaining default Vite styles like `body { display: flex; place-items: center; }` etc.
- The file should only contain: `@import "tailwindcss";`, CSS custom properties for themes, and Tailwind `@layer` directives

## 13. Next Steps

- Explore more shadcn/ui components
- Create custom components using shadcn/ui primitives
- Set up routing with React Router
- Add state management (Context API, Zustand, or Redux Toolkit)
- Configure testing with Vitest
- Set up deployment (Vercel, Netlify, etc.)
- Document your components with Storybook stories
- Set up ESLint and Prettier for code formatting

## Useful Resources

- [Vite Documentation](https://vitejs.dev/)
- [React Documentation](https://react.dev/)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [shadcn/ui Documentation](https://ui.shadcn.com/)
- [Vite React Template](https://github.com/vitejs/vite/tree/main/packages/create-vite/template-react)
- [Storybook Documentation](https://storybook.js.org/docs)
- [Storybook with Vite](https://storybook.js.org/docs/get-started/frameworks/react-vite)

Happy coding! 🚀