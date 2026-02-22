'use client'

import { Container, Title, Text, Button, Group } from '@mantine/core'
import dynamic from 'next/dynamic'

// Dynamically import the map to avoid SSR issues
const DynamicRouteMap = dynamic(
  () =>
    import('@/components/map/RouteMap').then(mod => ({
      default: mod.RouteMap,
    })),
  { ssr: false },
)

export default function Home() {
  return (
    <Container size="xl" py="xl">
      <div className="mb-8 text-center">
        <Title order={1} size="h1" mb="md">
          Map my Way
        </Title>
        <Text size="lg" c="dimmed" mb="xl">
          Create beautiful animated travel videos from your routes
        </Text>
        <Group justify="center" mb="xl">
          <Button size="lg">Create Route</Button>
          <Button size="lg" variant="outline">
            View Gallery
          </Button>
        </Group>
      </div>

      <div className="overflow-hidden rounded-lg shadow-lg">
        <DynamicRouteMap className="h-96 w-full" />
      </div>
    </Container>
  )
}
