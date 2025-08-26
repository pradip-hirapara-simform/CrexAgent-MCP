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
