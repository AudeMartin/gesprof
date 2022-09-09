import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

// Connects to data-controller="map-school-show"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    markerSchool: Object
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    this.#addMarkersToMap()
    this.#addMarkerSchoolToMap()
    this.#fitMapToMarkers()
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {

      if(marker.id !== this.markerSchoolValue.id) {
        const popup = new mapboxgl.Popup().setHTML(marker.info_window)
        const customMarker = document.createElement("div")
        customMarker.className = "marker marker-teacher"
        customMarker.style.backgroundSize = "contain"

        new mapboxgl.Marker(customMarker)
          .setLngLat([marker.longitude, marker.latitude ])
          .setPopup(popup)
          .addTo(this.map)
      }
    })
  }

  #addMarkerSchoolToMap() {
      const customMarker = document.createElement("div")
      customMarker.className = "marker marker-school1"
      customMarker.style.backgroundSize = "contain"

      new mapboxgl.Marker(customMarker)
        .setLngLat([this.markerSchoolValue.longitude, this.markerSchoolValue.latitude ])
        .addTo(this.map)
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.longitude, marker.latitude ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
