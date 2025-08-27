#!/bin/bash

# Enhanced React + Vite + Tailwind + shadcn/ui Setup Script
# This script automates the setup process to avoid common issues

set -e  # Exit on any error

echo "🚀 Enhanced React + Vite + Tailwind + shadcn/ui Setup"
echo "=================================================="

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check prerequisites
echo "🔍 Checking prerequisites..."
if ! command_exists pnpm; then
    echo "❌ pnpm is required but not installed. Please install pnpm first."
    echo "   npm install -g pnpm"
    exit 1
fi

if ! command_exists node; then
    echo "❌ Node.js is required but not installed."
    exit 1
fi

echo "✅ Prerequisites check passed"

# Check if we're in a Vite React project
if [ ! -f "package.json" ]; then
    echo "❌ No package.json found. Please run this script in a Vite React project directory."
    exit 1
fi

# Install required dependencies
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
      "@/*": ["src/*"]
    }
  },
  "files": [],
  "references": [
    { "path": "./tsconfig.app.json" },
    { "path": "./tsconfig.node.json" }
  ]
}
EOF

# Update tsconfig.app.json
echo "📝 Updating tsconfig.app.json..."
# Read existing tsconfig.app.json and add path aliases
if [ -f "tsconfig.app.json" ]; then
    # Use a more robust approach to update the existing file
    node -e "
    const fs = require('fs');
    const config = JSON.parse(fs.readFileSync('tsconfig.app.json', 'utf8'));
    config.compilerOptions = config.compilerOptions || {};
    config.compilerOptions.baseUrl = '.';
    config.compilerOptions.paths = { '@/*': ['src/*'] };
    fs.writeFileSync('tsconfig.app.json', JSON.stringify(config, null, 2));
    "
    echo "   ✅ tsconfig.app.json updated with path aliases"
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

# Ask about Storybook
echo ""
echo "📚 Do you want to set up Storybook? (y/n)"
read -r setup_storybook

if [[ $setup_storybook =~ ^[Yy]$ ]]; then
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
    fi
fi

# Update package.json scripts
echo "📝 Updating package.json scripts..."
node -e "
const fs = require('fs');
const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));
pkg.scripts = pkg.scripts || {};
pkg.scripts['add-component'] = 'pnpm dlx shadcn@latest add';
if (pkg.devDependencies && pkg.devDependencies.storybook) {
  pkg.scripts['storybook'] = 'storybook dev -p 6006';
  pkg.scripts['build-storybook'] = 'storybook build';
}
fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2));
"

echo ""
echo "✅ Setup Complete!"
echo "=================="
echo ""
echo "🚀 Your project is ready! Here's what to do next:"
echo ""
echo "1. Start development server:"
echo "   pnpm run dev"
echo ""
if [[ $setup_storybook =~ ^[Yy]$ ]]; then
echo "2. Start Storybook (in a new terminal):"
echo "   pnpm run storybook"
echo ""
fi
echo "3. Add more shadcn/ui components:"
echo "   pnpm run add-component [component-name]"
echo ""
echo "4. Your index.css backup is saved as src/index.css.backup"
echo ""
echo "🎉 Happy coding!"
