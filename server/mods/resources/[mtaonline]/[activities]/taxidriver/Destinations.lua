Destination = {
    x,
    y,
    z,
    name,
    color,
    marker,
    blip
}

function Destination.Render(self)
    self.marker = createMarker( x, y, z, "cylinder", 4)
    self.blip = createBlipAttachedTo(self.marker, 0)
end

function Destination.Destroy(self)
    destroyElement(self.marker)
    destroyElement(self.blip)
end

Destinations = {}

function Destinations.loadDestinations()

end

function Destinations.getDestinationNearPlayer(player, min_distance, max_distance)

end

function Destinations.createDestinationMarker(destination, r, g, b)
    local x,y,z = getElementPosition(destination)
    m = createMarker(x,y,z,"cylinder", 4, r, g, b)
    return m
end