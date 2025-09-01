#!/bin/bash

# React + Vite + Tailwind + shadcn/ui Setup Script (For Existing Project/Folder)
# This script sets up everything in the current directory

set -e  # Exit on any error

echo "🚀 React + Vite + Tailwind + shadcn/ui Setup (Current Directory)"
echo "================================================================"

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check prerequisites
echo "🔍 Checking prerequisites..."
if ! command_exists node; then
    echo "❌ Node.js is required but not installed."
    echo "   Please install Node.js from https://nodejs.org/ (version 18 or higher)"
    exit 1
fi

if ! command_exists pnpm; then
    echo "⚠️  pnpm not found. Installing pnpm..."
    npm install -g pnpm
fi

echo "✅ Prerequisites check passed"

# Check current directory
current_dir=$(basename "$PWD")
echo ""
echo "📁 Current directory: $current_dir"
echo "🔧 Setting up React project in this directory..."

# Check if package.json exists
if [ -f "package.json" ]; then
    echo "📋 Found existing package.json - will enhance existing project"
    existing_project=true
else
    echo "🆕 No package.json found - will create new Vite React project"
    existing_project=false
fi

echo ""
read -p "Do you want to continue setting up in this directory? (y/n): " confirm
if [[ ! $confirm =~ ^[Yy]$ ]]; then
    echo "❌ Setup cancelled"
    exit 1
fi

# Create new Vite React project if needed
if [ "$existing_project" = false ]; then
    echo "🎯 Creating new Vite React TypeScript project..."
    pnpm create vite@latest . --template react-ts
fi

# Install dependencies
echo "📦 Installing/updating dependencies..."
pnpm install

# Install Tailwind CSS v4 and required packages
echo "📦 Installing Tailwind CSS v4 and dependencies..."
pnpm install -D @tailwindcss/vite tailwindcss @tailwindcss/postcss postcss @types/node

# Critical: Clean index.css FIRST
echo "🧹 Cleaning src/index.css (CRITICAL STEP)..."
if [ -f "src/index.css" ]; then
    # Backup existing file
    cp src/index.css src/index.css.backup
    echo "   📋 Backed up existing index.css to index.css.backup"
fi

# Write only the Tailwind import
echo '@import "tailwindcss";' > src/index.css
echo "   ✅ index.css now contains only: @import \"tailwindcss\";"

# Update vite.config.ts
echo "⚙️ Updating vite.config.ts..."
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
echo "   ✅ vite.config.ts updated with Tailwind v4 and path aliases"

# Update tsconfig.json
echo "📝 Updating tsconfig.json..."
cat > tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"],
      "@/components": ["src/components/index.ts"],
      "@/components/*": ["src/components/*"],
      "@/components/common": ["src/components/common/index.ts"],
      "@/lib/*": ["src/lib/*"],
      "@/utils/*": ["src/utils/*"],
      "@/hooks/*": ["src/hooks/*"],
      "@/types/*": ["src/types/*"],
      "@/constants/*": ["src/constants/*"]
    }
  },
  "files": [],
  "references": [
    { "path": "./tsconfig.app.json" },
    { "path": "./tsconfig.node.json" }
  ]
}
EOF

# Update tsconfig.app.json with proper error handling
echo "📝 Updating tsconfig.app.json..."
if [ -f "tsconfig.app.json" ]; then
    # Use a more robust approach to update the existing file with better error handling
    node -e "
    try {
      const fs = require('fs');
      const config = JSON.parse(fs.readFileSync('tsconfig.app.json', 'utf8'));
      config.compilerOptions = config.compilerOptions || {};
      config.compilerOptions.baseUrl = '.';
      config.compilerOptions.paths = {
        '@/*': ['src/*'],
        '@/components': ['src/components/index.ts'],
        '@/components/*': ['src/components/*'],
        '@/components/common': ['src/components/common/index.ts'],
        '@/lib/*': ['src/lib/*'],
        '@/utils/*': ['src/utils/*'],
        '@/hooks/*': ['src/hooks/*'],
        '@/types/*': ['src/types/*'],
        '@/constants/*': ['src/constants/*']
      };
      fs.writeFileSync('tsconfig.app.json', JSON.stringify(config, null, 2));
      console.log('   ✅ tsconfig.app.json updated with comprehensive path aliases');
    } catch (error) {
      console.error('   ⚠️  Could not update tsconfig.app.json:', error.message);
    }
    "
fi

echo "🎨 Ready to initialize shadcn/ui..."
echo "   When prompted, use these settings:"
echo "   - TypeScript: Yes"
echo "   - Style: Default"
echo "   - Base color: Slate (or your preference)"
echo "   - CSS variables: Yes"
echo "   - Import alias: @/*"
echo ""
echo "Press Enter to continue with shadcn/ui initialization..."
read -r

# Initialize shadcn/ui
echo "🎨 Initializing shadcn/ui..."
pnpm dlx shadcn@latest init

# Install basic components
echo "🧩 Installing basic shadcn/ui components..."
pnpm dlx shadcn@latest add button card input

# Ask about ESLint and Prettier
echo ""
echo "🔧 Do you want to set up ESLint and Prettier? (y/n)"
read -r setup_linting

if [[ $setup_linting =~ ^[Yy]$ ]]; then
    echo "🔧 Setting up ESLint and Prettier..."
    
    # Install dependencies
    pnpm install -D eslint prettier eslint-config-prettier eslint-plugin-prettier
    pnpm install -D eslint-plugin-react eslint-plugin-react-hooks eslint-plugin-react-refresh
    pnpm install -D @typescript-eslint/eslint-plugin @typescript-eslint/parser
    pnpm install -D eslint-plugin-import eslint-plugin-jsx-a11y globals
    
    # Create ESLint config
    cat > eslint.config.js << 'EOF'
import js from '@eslint/js'
import globals from 'globals'
import reactHooks from 'eslint-plugin-react-hooks'
import reactRefresh from 'eslint-plugin-react-refresh'
import tseslint from '@typescript-eslint/eslint-plugin'
import tsparser from '@typescript-eslint/parser'
import react from 'eslint-plugin-react'
import prettier from 'eslint-config-prettier'

export default [
  {
    ignores: ['dist', 'node_modules', '.storybook', 'storybook-static'],
  },
  {
    files: ['**/*.{js,jsx,ts,tsx}'],
    languageOptions: {
      ecmaVersion: 2020,
      globals: globals.browser,
      parser: tsparser,
      parserOptions: {
        ecmaVersion: 'latest',
        ecmaFeatures: { jsx: true },
        sourceType: 'module',
      },
    },
    settings: { react: { version: '18.3' } },
    plugins: {
      react,
      'react-hooks': reactHooks,
      'react-refresh': reactRefresh,
      '@typescript-eslint': tseslint,
    },
    rules: {
      ...js.configs.recommended.rules,
      ...react.configs.recommended.rules,
      ...react.configs['jsx-runtime'].rules,
      ...reactHooks.configs.recommended.rules,
      ...tseslint.configs.recommended.rules,
      'react-refresh/only-export-components': [
        'warn',
        { allowConstantExport: true },
      ],
      'prettier/prettier': 'error',
      'react/prop-types': 'off',
      '@typescript-eslint/no-unused-vars': ['error', { argsIgnorePattern: '^_' }],
      'no-console': 'warn',
      'prefer-const': 'error',
    },
  },
  prettier,
]
EOF

    # Create Prettier config
    cat > .prettierrc.json << 'EOF'
{
  "semi": false,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false,
  "bracketSpacing": true,
  "bracketSameLine": false,
  "arrowParens": "avoid",
  "endOfLine": "lf",
  "jsxSingleQuote": true,
  "quoteProps": "as-needed"
}
EOF

    # Create Prettier ignore
    cat > .prettierignore << 'EOF'
# Build outputs
dist/
build/
*.tsbuildinfo

# Dependencies
node_modules/

# Logs
*.log

# Coverage directory
coverage/

# OS generated files
.DS_Store
Thumbs.db

# Storybook
storybook-static/

# Package manager files
pnpm-lock.yaml
yarn.lock
package-lock.json
EOF

    # Create VS Code settings
    mkdir -p .vscode
    cat > .vscode/settings.json << 'EOF'
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": "explicit",
    "source.organizeImports": "explicit"
  },
  "eslint.validate": [
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact"
  ],
  "typescript.preferences.importModuleSpecifier": "relative"
}
EOF

    echo "   ✅ ESLint and Prettier configured"
fi

# Update package.json scripts with better error handling
echo "📝 Updating package.json scripts..."
node -e "
try {
  const fs = require('fs');
  const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));
  
  // Ensure scripts object exists
  pkg.scripts = pkg.scripts || {};
  
  // Add comprehensive scripts
  pkg.scripts['add-component'] = 'pnpm dlx shadcn@latest add';
  pkg.scripts['lint'] = 'eslint . --ext js,jsx,ts,tsx --report-unused-disable-directives --max-warnings 0';
  pkg.scripts['lint:fix'] = 'eslint . --ext js,jsx,ts,tsx --fix';
  pkg.scripts['format'] = 'prettier --write .';
  pkg.scripts['format:check'] = 'prettier --check .';
  pkg.scripts['type-check'] = 'tsc --noEmit';
  pkg.scripts['test'] = 'vitest';
  pkg.scripts['test:coverage'] = 'vitest --coverage';
  pkg.scripts['test:ui'] = 'vitest --ui';
  pkg.scripts['clean'] = 'rm -rf dist node_modules/.vite';
  pkg.scripts['deps:update'] = 'pnpm update --interactive --latest';
  
  // Write back to file
  fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2));
  console.log('   ✅ package.json scripts updated with best practices');
} catch (error) {
  console.error('   ⚠️  Could not update package.json:', error.message);
}
"

# Create a test component
echo "🧪 Creating optimized project structure and components..."

# Create organized folder structure
mkdir -p src/components/common src/components/forms src/pages
mkdir -p src/hooks src/utils src/types src/constants src/services

# Create barrel export for components/ui
cat > src/components/ui/index.ts << 'EOF'
// Re-export all UI components
export { Button } from './button'
export { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from './card'
export { Input } from './input'
EOF

# Create barrel export for components/common
cat > src/components/common/index.ts << 'EOF'
// Re-export all common components
export { TestComponent } from './TestComponent'
EOF

# Create main components barrel export
cat > src/components/index.ts << 'EOF'
// Re-export all components
export * from './ui'
export * from './common'
EOF

# Create constants file
cat > src/constants/index.ts << 'EOF'
/**
 * Application constants
 */

export const APP_NAME = 'React App'
export const APP_VERSION = '1.0.0'
export const APP_DESCRIPTION = 'A modern React application with Vite, TypeScript, and Tailwind CSS'

// API endpoints
export const API_BASE_URL = import.meta.env.VITE_API_BASE_URL || 'http://localhost:3000/api'

// Local storage keys
export const STORAGE_KEYS = {
  USER_PREFERENCES: 'user_preferences',
  THEME: 'theme',
  LANGUAGE: 'language',
} as const

// Theme options
export const THEMES = {
  LIGHT: 'light',
  DARK: 'dark',
  SYSTEM: 'system',
} as const

// Breakpoints (matching Tailwind CSS)
export const BREAKPOINTS = {
  SM: 640,
  MD: 768,
  LG: 1024,
  XL: 1280,
  '2XL': 1536,
} as const

// Animation durations
export const ANIMATION_DURATION = {
  FAST: 150,
  NORMAL: 300,
  SLOW: 500,
} as const
EOF

# Create types file
cat > src/types/index.ts << 'EOF'
/**
 * Common TypeScript type definitions
 */

// Base types
export type ID = string | number

// API Response types
export interface ApiResponse<T = unknown> {
  data: T
  message?: string
  success: boolean
  error?: string
}

export interface ApiError {
  message: string
  code?: string | number
  details?: unknown
}

// Component props
export interface BaseComponentProps {
  className?: string
  children?: React.ReactNode
}

// Theme types
export type Theme = 'light' | 'dark' | 'system'

// Loading states
export type LoadingState = 'idle' | 'loading' | 'success' | 'error'

// Form types
export interface FormState<T = Record<string, unknown>> {
  data: T
  errors: Partial<Record<keyof T, string>>
  isValid: boolean
  isDirty: boolean
  isSubmitting: boolean
}

// User types (example)
export interface User {
  id: ID
  name: string
  email: string
  avatar?: string
  role: 'admin' | 'user'
  createdAt: string
  updatedAt: string
}

// Pagination
export interface PaginationParams {
  page: number
  limit: number
  sortBy?: string
  sortOrder?: 'asc' | 'desc'
}

export interface PaginatedResponse<T> {
  data: T[]
  pagination: {
    page: number
    limit: number
    total: number
    totalPages: number
  }
}
EOF

# Create utility functions
cat > src/utils/index.ts << 'EOF'
/**
 * Utility functions for common operations
 */

/**
 * Formats a number as currency
 */
export const formatCurrency = (amount: number, currency = 'USD'): string => {
  return new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency,
  }).format(amount)
}

/**
 * Capitalizes the first letter of a string
 */
export const capitalize = (str: string): string => {
  return str.charAt(0).toUpperCase() + str.slice(1).toLowerCase()
}

/**
 * Debounce function to limit function calls
 */
export const debounce = <T extends (...args: unknown[]) => void>(
  func: T,
  wait: number
): ((...args: Parameters<T>) => void) => {
  let timeout: NodeJS.Timeout
  return (...args: Parameters<T>) => {
    clearTimeout(timeout)
    timeout = setTimeout(() => func(...args), wait)
  }
}

/**
 * Generate a random ID
 */
export const generateId = (): string => {
  return Math.random().toString(36).substring(2) + Date.now().toString(36)
}

/**
 * Check if value is empty (null, undefined, empty string, empty array, empty object)
 */
export const isEmpty = (value: unknown): boolean => {
  if (value == null) return true
  if (typeof value === 'string' || Array.isArray(value)) return value.length === 0
  if (typeof value === 'object') return Object.keys(value).length === 0
  return false
}
EOF

# Create custom hooks
cat > src/hooks/index.ts << 'EOF'
import { useState, useEffect } from 'react'

/**
 * Custom hook for localStorage with React state
 */
export function useLocalStorage<T>(
  key: string,
  initialValue: T
): [T, (value: T | ((val: T) => T)) => void] {
  // Get value from localStorage or use initial value
  const [storedValue, setStoredValue] = useState<T>(() => {
    try {
      const item = window.localStorage.getItem(key)
      return item ? JSON.parse(item) : initialValue
    } catch (error) {
      console.error(`Error reading localStorage key "${key}":`, error)
      return initialValue
    }
  })

  // Return a wrapped version of useState's setter function that persists the new value to localStorage
  const setValue = (value: T | ((val: T) => T)) => {
    try {
      // Allow value to be a function so we have the same API as useState
      const valueToStore = value instanceof Function ? value(storedValue) : value
      setStoredValue(valueToStore)
      window.localStorage.setItem(key, JSON.stringify(valueToStore))
    } catch (error) {
      console.error(`Error setting localStorage key "${key}":`, error)
    }
  }

  return [storedValue, setValue]
}

/**
 * Custom hook for handling async operations
 */
export function useAsync<T, E = string>(
  asyncFunction: () => Promise<T>,
  immediate = true
) {
  const [status, setStatus] = useState<'idle' | 'pending' | 'success' | 'error'>('idle')
  const [data, setData] = useState<T | null>(null)
  const [error, setError] = useState<E | null>(null)

  const execute = async () => {
    setStatus('pending')
    setData(null)
    setError(null)

    try {
      const response = await asyncFunction()
      setData(response)
      setStatus('success')
      return response
    } catch (error) {
      setError(error as E)
      setStatus('error')
      throw error
    }
  }

  useEffect(() => {
    if (immediate) {
      execute()
    }
  }, [immediate])

  return {
    execute,
    status,
    data,
    error,
    isLoading: status === 'pending',
    isSuccess: status === 'success',
    isError: status === 'error',
  }
}

/**
 * Custom hook for debounced values
 */
export function useDebounce<T>(value: T, delay: number): T {
  const [debouncedValue, setDebouncedValue] = useState<T>(value)

  useEffect(() => {
    const handler = setTimeout(() => {
      setDebouncedValue(value)
    }, delay)

    return () => {
      clearTimeout(handler)
    }
  }, [value, delay])

  return debouncedValue
}
EOF

# Create test utilities
cat > src/utils/test-utils.tsx << 'EOF'
/**
 * Test utilities and common setup
 * Note: Install @testing-library/react for testing support
 */

// Placeholder for testing utilities
// Install: pnpm install -D @testing-library/react @testing-library/jest-dom

export const createMockComponent = (name: string) => {
  const MockComponent = () => <div data-testid={`mock-${name}`}>{name}</div>
  MockComponent.displayName = `Mock${name}`
  return MockComponent
}

export const delay = (ms: number) => new Promise(resolve => setTimeout(resolve, ms))
EOF

# Create optimized TestComponent
cat > src/components/common/TestComponent.tsx << 'EOF'
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Input } from "@/components/ui/input"
import { APP_NAME } from "@/constants"

export function TestComponent() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 py-8">
      <div className="container mx-auto px-4">
        <h1 className="text-4xl font-bold text-center mb-8 text-gray-800">
          🚀 {APP_NAME} is Ready!
        </h1>
        
        <Card className="max-w-md mx-auto shadow-lg">
          <CardHeader>
            <CardTitle className="text-2xl text-center text-blue-600">
              Setup Complete
            </CardTitle>
            <CardDescription className="text-center">
              React + Vite + Tailwind CSS + shadcn/ui
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <Input 
              placeholder="Test input component..." 
              className="w-full"
            />
            <Button className="w-full">
              Test Button Component
            </Button>
            <div className="text-sm text-gray-600 text-center">
              ✅ Tailwind CSS working<br/>
              ✅ shadcn/ui components working<br/>
              ✅ Path aliases working (@/components)<br/>
              ✅ Constants imported<br/>
              ✅ Optimized project structure<br/>
              ✅ Custom hooks available<br/>
              ✅ TypeScript types defined<br/>
              ✅ Utility functions ready
            </div>
          </CardContent>
        </Card>
        
        <div className="mt-8 text-center text-sm text-gray-600">
          <p>Edit <code className="bg-gray-200 px-2 py-1 rounded">src/App.tsx</code> to start building your app</p>
          <p className="mt-2">Check <code className="bg-gray-200 px-2 py-1 rounded">src/</code> for organized folder structure</p>
        </div>
      </div>
    </div>
  )
}
EOF

# Create environment variables example
cat > .env.example << 'EOF'
# Development environment variables
VITE_APP_NAME=React App
VITE_APP_VERSION=1.0.0
VITE_API_BASE_URL=http://localhost:3000/api

# Feature flags
VITE_ENABLE_DEV_TOOLS=true
VITE_ENABLE_STORYBOOK=true

# Analytics (optional)
# VITE_GA_TRACKING_ID=
# VITE_SENTRY_DSN=
EOF

# Create enhanced README
cat > README.md << 'EOF'
# React App

A modern React application built with Vite, TypeScript, Tailwind CSS, and shadcn/ui components.

## 🚀 Features

- ⚡️ **Vite 7** - Lightning fast build tool
- ⚛️ **React 19** - Latest React with concurrent features
- 🎨 **Tailwind CSS v4** - Latest utility-first CSS framework
- 🧩 **shadcn/ui** - Beautiful, accessible components
- 📚 **Storybook** - Component development and documentation
- 🔧 **TypeScript** - Full type safety
- 🧹 **ESLint + Prettier** - Code quality and formatting
- 🧪 **Vitest** - Fast unit testing
- 📱 **Responsive Design** - Mobile-first approach

## 📦 Installation

```bash
# Install dependencies
pnpm install

# Start development server
pnpm run dev

# Start Storybook (if installed)
pnpm run storybook
```

## 🛠️ Available Scripts

| Script | Description |
|--------|-------------|
| `pnpm run dev` | Start development server |
| `pnpm run build` | Build for production |
| `pnpm run preview` | Preview production build |
| `pnpm run lint` | Run ESLint |
| `pnpm run lint:fix` | Fix ESLint issues |
| `pnpm run format` | Format code with Prettier |
| `pnpm run type-check` | Check TypeScript types |
| `pnpm run test` | Run tests |
| `pnpm run storybook` | Start Storybook |
| `pnpm run add-component` | Add shadcn/ui component |

## 🏗️ Project Structure

```
src/
├── components/          # Reusable components
│   ├── ui/             # shadcn/ui components
│   ├── common/         # Common components
│   └── forms/          # Form components
├── hooks/              # Custom React hooks
├── utils/              # Utility functions
├── types/              # TypeScript definitions
├── constants/          # App constants
├── services/           # API services
├── pages/              # Page components
└── __tests__/          # Test files
```

## 🎨 Adding Components

```bash
# Add a new shadcn/ui component
pnpm run add-component button
pnpm run add-component card
pnpm run add-component input
```

## 🧪 Testing

```bash
# Run tests
pnpm run test

# Run tests with coverage
pnpm run test:coverage
```

## 🚀 Deployment

```bash
# Build for production
pnpm run build

# Preview production build
pnpm run preview
```

## 🛡️ Tech Stack

- **Frontend:** React 19, TypeScript
- **Build Tool:** Vite 7
- **Styling:** Tailwind CSS v4
- **UI Components:** shadcn/ui + Radix UI
- **Testing:** Vitest
- **Documentation:** Storybook
- **Code Quality:** ESLint + Prettier
- **Package Manager:** pnpm

## 📋 Best Practices

This project follows modern React best practices:
- Component composition over inheritance
- Custom hooks for logic reuse  
- TypeScript for type safety
- Atomic design principles
- Accessibility-first approach
EOF

# Update App.tsx to use the test component
cat > src/App.tsx << 'EOF'
import { TestComponent } from '@/components/common'
import './App.css'

function App() {
  return <TestComponent />
}

export default App
EOF

# Initialize git repository if not already initialized
if [ ! -d ".git" ]; then
    echo "📂 Initializing git repository..."
    git init
    git add .
    git commit -m "feat: initial project setup with React + Vite + Tailwind + shadcn/ui

- Configured Tailwind CSS v4
- Set up shadcn/ui with basic components
- Added path aliases support
- Created test component to verify setup"
else
    echo "📂 Git repository already exists"
fi

echo ""
echo "✅ Core Setup Complete!"
echo "======================="
echo ""
echo "🎉 Basic React project setup is finished!"
echo ""

# Optional Storybook setup at the end
echo "📚 Optional: Do you want to set up Storybook now? (y/n)"
echo "   (You can also set it up later by running: pnpm dlx storybook@latest init)"
read -r setup_storybook

if [[ $setup_storybook =~ ^[Yy]$ ]]; then
    echo ""
    echo "📚 Setting up Storybook..."
    pnpm dlx storybook@latest init
    
    # Configure Storybook for Tailwind v4
    echo "⚙️ Configuring Storybook for Tailwind v4..."
    
    if [ -d ".storybook" ]; then
        cat > .storybook/main.ts << 'EOF'
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
EOF

        cat > .storybook/preview.ts << 'EOF'
import type { Preview } from '@storybook/react';
import '../src/index.css';

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
EOF
        echo "   ✅ Storybook configured for Tailwind v4"
        
        # Update package.json to add storybook scripts
        node -e "
        try {
          const fs = require('fs');
          const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));
          pkg.scripts = pkg.scripts || {};
          pkg.scripts['storybook'] = 'storybook dev -p 6006';
          pkg.scripts['build-storybook'] = 'storybook build';
          fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2));
          console.log('   ✅ Storybook scripts added to package.json');
        } catch (error) {
          console.error('   ⚠️  Could not update package.json for Storybook');
        }
        "
    fi
    storybook_installed=true
else
    storybook_installed=false
fi

echo ""
echo "✅ Complete Setup Finished!"
echo "=========================="
echo ""
echo "🎉 Your React project in '$current_dir' is ready!"
echo ""
echo "📁 Project location: $(pwd)"
echo ""
echo "🚀 What to do next:"
echo ""
echo "1. Start development server:"
echo "   pnpm run dev"
echo ""
if [ "$storybook_installed" = true ]; then
echo "2. Start Storybook (in a new terminal):"
echo "   pnpm run storybook"
echo ""
fi
if [[ $setup_linting =~ ^[Yy]$ ]]; then
echo "3. Lint and format your code:"
echo "   pnpm run lint        # Check for issues"
echo "   pnpm run lint:fix    # Fix issues automatically"
echo "   pnpm run format      # Format with Prettier"
echo "   pnpm run type-check  # Check TypeScript types"
echo ""
fi
echo "4. Add more shadcn/ui components:"
echo "   pnpm run add-component [component-name]"
echo ""
if [ "$storybook_installed" = false ]; then
echo "5. Set up Storybook later (optional):"
echo "   pnpm dlx storybook@latest init"
echo ""
fi
echo "6. Your original index.css backup is saved as src/index.css.backup"
echo ""
if [[ $setup_linting =~ ^[Yy]$ ]]; then
echo "📋 Recommended VS Code Extensions:"
echo "   - ESLint (dbaeumer.vscode-eslint)"
echo "   - Prettier (esbenp.prettier-vscode)"
echo "   - Auto Rename Tag (formulahendry.auto-rename-tag)"
echo "   - Tailwind CSS IntelliSense (bradlc.vscode-tailwindcss)"
echo ""
fi
echo "🎯 Open your browser and navigate to the local dev server to see your app!"
echo ""
echo "🎉 Happy coding!"