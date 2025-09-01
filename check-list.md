# shadcn/ui + Tailwind v4 Project Setup Checklist

This checklist follows the steps in `shadcn-setup.md` to ensure your project is fully configured.

---

- [ ] **Project Initialization**
  - [ ] Vite + React + TypeScript project created (`pnpm create vite@latest . -- --template react-ts`)
  - [ ] Dependencies installed (`pnpm install`)
  - [ ] Remove all content from `src/index.css` before adding Tailwind imports

- [ ] **Tailwind CSS v4**
  - [ ] Tailwind CSS v4 and @tailwindcss/vite installed (`pnpm add tailwindcss @tailwindcss/vite`)
  - [ ] `src/index.css` updated with Tailwind imports and @theme variables

- [ ] **ESLint Setup**
  - [ ] ESLint and recommended plugins installed
  - [ ] `eslint.config.js` created and configured

- [ ] **Prettier Setup**
  - [ ] Prettier installed
  - [ ] `.prettierrc` and `.prettierignore` created

- [ ] **Husky & lint-staged**
  - [ ] Husky and lint-staged installed (`pnpm add -D husky lint-staged`)
  - [ ] Husky initialized (`npx husky init`)
  - [ ] `.husky/pre-commit` runs `npx lint-staged`
  - [ ] `lint-staged` config added to `package.json`

- [ ] **shadcn/ui CLI**
  - [ ] shadcn/ui CLI initialized (`pnpm dlx shadcn-ui@latest init`)
  - [ ] CLI configured for React, Tailwind, and correct paths

- [ ] **Component Utilities**
  - [ ] `src/lib/utils.ts` created with `cn` utility
  - [ ] `clsx` and `tailwind-merge` installed

- [ ] **Path Aliases**
  - [ ] Path aliases set in `tsconfig.app.json` and `vite.config.ts`

- [ ] **Add Components**
  - [ ] shadcn/ui components added (e.g., button, card, dialog, input, label)
  - [ ] Components appear in `src/components/ui/`

- [ ] **Dark Mode**
  - [ ] `src/components/theme-provider.tsx` created for theme switching
  - [ ] Dark mode CSS variables set in `src/index.css`

- [ ] **Example Usage**
  - [ ] `src/App.tsx` uses shadcn/ui components and theme provider

- [ ] **Project Structure**
  - [ ] Project matches recommended structure (see shadcn-setup.md)

- [ ] **VS Code Integration**
  - [ ] Recommended extensions installed (ESLint, Prettier, Tailwind CSS)

---

For detailed steps, see `.github/shadcn-setup.md`.

- [ ] **Dark Mode Support**
  - [ ] Theme variables and dark mode in `src/index.css`
  - [ ] `src/components/theme-provider.tsx` created

- [ ] **Example Usage**
  - [ ] `src/App.tsx` uses shadcn/ui components and theme provider
  - [ ] `src/main.tsx` imports `App` and `index.css`

- [ ] **Scripts & Linting**
  - [ ] `package.json` scripts: `dev`, `build`, `preview`, `lint`, `lint:fix`, `format`, `format:check`, `type-check`, `type-check:watch`

- [ ] **VS Code Integration**
  - [ ] Recommended extensions/settings applied (optional)

---

Check off each item as you complete your setup!
