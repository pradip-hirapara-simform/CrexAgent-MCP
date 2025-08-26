import type { StorybookConfig } from '@storybook/react-vite';

const config: StorybookConfig = {
  "stories": [
    "../src/**/*.mdx",
    "../src/**/*.stories.@(js|jsx|mjs|ts|tsx)"
  ],
  "addons": [
    "@chromatic-com/storybook",
    "@storybook/addon-docs",
    "@storybook/addon-onboarding",
    "@storybook/addon-a11y",
    "@storybook/addon-vitest"
  ],
  "framework": {
    "name": "@storybook/react-vite",
    "options": {}
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