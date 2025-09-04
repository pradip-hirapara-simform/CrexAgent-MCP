# Figma Design Tokens Integration

This project integrates design tokens from Figma into the shadcn/ui + Tailwind CSS v4 setup using semantic color mapping.

## 🎨 Color Mapping

### Figma Variables → shadcn/ui Semantic Colors

- **Primary**: Clementine (`#DD6000`) - Main brand orange
- **Secondary**: Lochmara (`#0096DB`) - Secondary blue
- **Accent**: Vida Loca (`#66BC29`) - Success green
- **Muted**: Secondary Background (`#E6E7E8`) - Light surfaces
- **Muted Foreground**: Shuttle Gray (`#54565B`) - Text color

## 🚀 Usage

### Using shadcn/ui Semantic Colors

```tsx
// Primary brand color (Clementine)
<Button>Primary Button</Button>
<Button variant="secondary">Secondary Button</Button>
<Button variant="outline">Outline Button</Button>

// Custom accent color
<Button className="bg-accent hover:bg-accent/90 text-accent-foreground">
  Accent Button
</Button>

// Backgrounds and text
<div className="bg-primary text-primary-foreground">Primary background</div>
<div className="bg-secondary text-secondary-foreground">Secondary background</div>
<div className="bg-muted text-muted-foreground">Muted background</div>
```

### Available Semantic Classes

```css
/* Primary (Clementine) */
.bg-primary
.text-primary
.border-primary
.ring-primary

/* Secondary (Lochmara) */
.bg-secondary
.text-secondary
.border-secondary

/* Accent (Vida Loca) */
.bg-accent
.text-accent
.border-accent

/* Muted colors */
.bg-muted
.text-muted-foreground
.border-muted
```

## 🌙 Dark Mode Support

All colors automatically adapt to dark mode with appropriate contrast adjustments while maintaining the brand color integrity.

## 📁 Key Files

- `src/index.css` - CSS custom properties and Tailwind theme configuration
- `components.json` - shadcn/ui configuration

## 🔄 Updating Colors

To update colors from Figma:

1. Use the Figma MCP server to get new variable definitions
2. Update the CSS custom properties in `src/index.css` `:root` and `.dark` sections
3. The changes will automatically propagate throughout the application

## 🎯 Benefits of Semantic Approach

1. **Consistent Design System**: Uses shadcn/ui's proven semantic color system
2. **Easy Maintenance**: Change colors in one place, updates everywhere
3. **Dark Mode Ready**: Automatic dark mode adaptations
4. **Component Compatibility**: Works seamlessly with all shadcn/ui components
5. **No Additional Dependencies**: Uses only standard Tailwind and CSS custom properties
