import { ThemeProvider, useTheme } from "@/components/theme-provider";
import { Button } from "@/components/ui/button";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";

function ThemeToggle() {
  const { theme, setTheme } = useTheme();

  return (
    <Button
      variant="outline"
      onClick={() => setTheme(theme === "dark" ? "light" : "dark")}
    >
      {theme === "dark" ? "☀️" : "🌙"}
    </Button>
  );
}

function ColorShowcase() {
  return (
    <Card>
      <CardHeader>
        <CardTitle>Figma Design Tokens</CardTitle>
        <CardDescription>
          Colors integrated from your Figma design system using shadcn/ui
          semantic colors
        </CardDescription>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
          {/* Primary Colors */}
          <div className="space-y-2">
            <h4 className="text-sm font-medium">Primary</h4>
            <div className="space-y-2">
              <div
                className="h-12 rounded border bg-primary"
                title="Clementine - Primary"
              />
              <p className="text-xs text-muted-foreground">
                Clementine (#DD6000)
              </p>
            </div>
          </div>

          {/* Secondary Colors */}
          <div className="space-y-2">
            <h4 className="text-sm font-medium">Secondary</h4>
            <div className="space-y-2">
              <div
                className="h-12 rounded border bg-secondary"
                title="Lochmara - Secondary"
              />
              <p className="text-xs text-muted-foreground">
                Lochmara (#0096DB)
              </p>
            </div>
          </div>

          {/* Accent Colors */}
          <div className="space-y-2">
            <h4 className="text-sm font-medium">Accent</h4>
            <div className="space-y-2">
              <div
                className="h-12 rounded border bg-accent"
                title="Vida Loca - Accent"
              />
              <p className="text-xs text-muted-foreground">
                Vida Loca (#66BC29)
              </p>
            </div>
          </div>

          {/* Muted Colors */}
          <div className="space-y-2">
            <h4 className="text-sm font-medium">Muted</h4>
            <div className="space-y-2">
              <div
                className="h-12 rounded border bg-muted"
                title="Secondary Background - Muted"
              />
              <p className="text-xs text-muted-foreground">
                Background (#E6E7E8)
              </p>
            </div>
          </div>
        </div>
      </CardContent>
    </Card>
  );
}

function AppContent() {
  return (
    <div className="min-h-screen bg-background p-8">
      <div className="max-w-4xl mx-auto space-y-8">
        <header className="flex justify-between items-center">
          <h1 className="text-4xl font-bold">
            Figma + shadcn/ui + Tailwind v4
          </h1>
          <ThemeToggle />
        </header>

        <ColorShowcase />

        <Card>
          <CardHeader>
            <CardTitle>Component Examples</CardTitle>
            <CardDescription>
              shadcn/ui components using your Figma design tokens
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <p className="text-muted-foreground">
              These buttons now use Clementine as primary and other Figma colors
              mapped to shadcn/ui semantic colors.
            </p>
            <div className="flex gap-2 flex-wrap">
              <Button>Primary (Clementine)</Button>
              <Button variant="secondary">Secondary (Lochmara)</Button>
              <Button variant="outline">Outline</Button>
              <Button variant="destructive">Destructive</Button>
              <Button className="bg-accent hover:bg-accent/90 text-accent-foreground">
                Accent (Vida Loca)
              </Button>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}

function App() {
  return (
    <ThemeProvider defaultTheme="system" storageKey="vite-ui-theme">
      <AppContent />
    </ThemeProvider>
  );
}

export default App;
