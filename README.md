
# BMQuadtree

Swift implementation of a Quadtree, intended as a replacement for GameplayKit's `GKQuadtree`. This package offers an optimized way to perform spatial searches, dividing space into quadrants for efficient lookup.

## Features

- Drop-in replacement for GameplayKit's `GKQuadtree`.
- Efficient spatial searches.
- Supports any object type (`AnyObject`).
- Extension methods for `GKQuad` for added utility.

## Installation

### Swift Package Manager

1. In Xcode, select File > Swift Packages > Add Package Dependency.
2. Enter the repository URL of this package, then click Next.
3. Select the version you want to use, then click Next.
4. Choose the target where you want to use this package, then click Finish.

## Usage

### Creating A Tree

A tree is initialised with a bounding quad (axis-aligned bounding rectangle), a minimum cell size and a maximum depth.

```swift
let tree = BMQuadtree(
  boundingQuad: boundingQuad,
  minimumCellSize: 3)
```

By default, the minimum cell size is 1, but it does make sense to use a larger cell size, for instance 3.

### Adding And Removing Elements

```swift
let location = CLLocation(latitude: item.latitude, longitude: item.longitude)
tree.add(location, at: float2(item.latitude, item.longitude))
tree.remove(location)
```

### Searching For Elements

Nearest neighbour to a defined point:

```swift
let nearest = tree.element(nearestTo: float2(0, 0))
```

You can filter for different types (classes) when performing a nearest element search:

```swift
let nearestOfType: CLLocation? =
  tree.element(
  	nearestTo: float2(0, 0), 
  	type: CLLocation.self) as? CLLocation
```

All of the elements in the quadtree node this point would be placed in:

```swift
let elementAtPoint = tree.elements(at: float2(0, 0))
```

All of the elements that reside in quadtree nodes which intersect the given quad. Recursively check if the search quad contains the points in the quad:

```swift
let searchQuad = GKQuad(
	quadMin: float2(-10, -10), 
	quadMax: float2(10, 10))

let elementInQuad = tree.elements(in: searchQuad)
```

### Extensions for MapKit

To be able to use the quadtree for managing map data (locations, coordinates, instructions, POIs, etc.), there are a few extensions available for your convenience.

#### GKQuad With CLLocation And Offset

To define a quad using coordinates and offset in meters:

```swift
let vienna = CLLocation(latitude: 48.21128, longitude: 16.364537)
let quad = GKQuad(location: vienna, offset: 5000)
```

#### GKQuad For Overlays

If you have a track you show on the map as an MKOverlay, you can access the bounding quad using:

```swift
let quad = trackOverlay.boundingQuad
```

#### CLLocationCoordinate2D And CLLocation To vector_float2

As float2-s are used to store the location of the objects, there are convenience properties to work with CLLocation and CLLocationCoordinate2D:

```swift
let vienna = CLLocation(latitude: 48.21128, longitude: 16.364537)
let vector = vienna.vector

let vienna = CLLocationCoordinate2DMake(latitude: 48.21128, longitude: 16.364537)
let vector = vienna.vector
```

### Debugging

To visualize and debug the quadtree on the map, use the `debugOverlay` property of the tree and add it as a new overlay:

```swift
let quadtreeDebugOverlay: MKOverlay = tree?.debugOverlay
map.add(quadtreeDebugOverlay)
```

## License

Please refer to the `LICENSE` file for details on usage, modification, and distribution of this package.
