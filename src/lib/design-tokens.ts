/**
 * Design tokens extracted from Figma
 * These constants provide type-safe access to your design system colors
 */

export const figmaTokens = {
  colors: {
    // Primary palette
    clementine: "#DD6000",
    clementineBase: "#dd6000",
    shuttleGray: "#54565B",
    shuttleGrayBase: "#636466",
    lochmara: "#0096DB",
    vidaLoca: "#66BC29",

    // Secondary palette
    buttercup: "#F5B324",
    ecstasy: "#F68C23",
    secondaryText: "#4D4D4D",
    secondaryBackground: "#E6E7E8",
  },
} as const;

/**
 * Semantic color mappings for shadcn/ui components
 * Maps Figma tokens to shadcn/ui's design system
 */
export const semanticColors = {
  primary: figmaTokens.colors.lochmara, // Blue - main brand color
  secondary: figmaTokens.colors.clementine, // Orange - secondary brand
  accent: figmaTokens.colors.vidaLoca, // Green - success/accent
  warning: figmaTokens.colors.buttercup, // Yellow - warnings
  danger: figmaTokens.colors.ecstasy, // Orange-red - errors/alerts
  muted: figmaTokens.colors.shuttleGray, // Gray - muted text
  mutedBackground: figmaTokens.colors.secondaryBackground, // Light gray - surfaces
} as const;

/**
 * Utility classes for Tailwind CSS
 * Use these in your components: className="bg-brand-primary text-brand-primary-foreground"
 */
export const brandClasses = {
  // Primary brand colors
  primary: {
    background: "bg-lochmara",
    text: "text-lochmara",
    border: "border-lochmara",
    hover: "hover:bg-lochmara/90",
  },

  // Secondary brand colors
  secondary: {
    background: "bg-clementine",
    text: "text-clementine",
    border: "border-clementine",
    hover: "hover:bg-clementine/90",
  },

  // Accent colors
  accent: {
    background: "bg-vida-loca",
    text: "text-vida-loca",
    border: "border-vida-loca",
    hover: "hover:bg-vida-loca/90",
  },

  // Utility colors
  warning: {
    background: "bg-buttercup",
    text: "text-buttercup",
    border: "border-buttercup",
    hover: "hover:bg-buttercup/90",
  },
} as const;

// Type exports for better TypeScript support
export type FigmaColor = keyof typeof figmaTokens.colors;
export type SemanticColor = keyof typeof semanticColors;
export type BrandClass = keyof typeof brandClasses;
