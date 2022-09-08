import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl';
var n = -1
var interval
var markArray = []
var checkArray = []
// Connects to data-controller="mapanimated"
export default class extends Controller {
  static values = {
    apiKey: String,
    startMarkers: Array,
    endMarkers: Array,
  };

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    this.#addStartMarkersToMap()
    this.#addEndMarkersToMap()
    this.#fitMapToMarkers();
    interval = setInterval(this.#animateMarker.bind(this), 200);
  }
  #addStartMarkersToMap() {
    this.startMarkersValue.forEach((marker) => {
      const customMarker = document.createElement("div")
      customMarker.className = "marker marker-school1"
      this.marker = new mapboxgl.Marker(customMarker)
      new mapboxgl.Marker(customMarker)
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(this.map)
    })
  }
  #addEndMarkersToMap() {
    this.endMarkersValue.forEach((marker) => {
      const customMarker = document.createElement("div")
      customMarker.className = "marker marker-school2"
      this.marker = new mapboxgl.Marker(customMarker)
      new mapboxgl.Marker(customMarker)
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(this.map)
    })
  }
  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.endMarkersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.startMarkersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  #animateMarker() {
    n += 1
    markArray.forEach(element => { element.remove() });
    markArray = []
    this.startMarkersValue.forEach((start_marker) => {
      const end_marker = this.endMarkersValue.find(em => em.school_id == start_marker.school_id)
      const a = (Math.abs(end_marker.lat - start_marker.lat) / 40.0)
      const b = (Math.abs(end_marker.lng - start_marker.lng) / 40.0)

      if (end_marker.lat > start_marker.lat){
        start_marker.lat += n*a}
      else {
        start_marker.lat -= n*a
      }
      if (end_marker.lng > start_marker.lng){
        start_marker.lng += n*b}
      else {
        start_marker.lng -= n*b}

      const customMarker = document.createElement("div")
      customMarker.className = "marker marker-teacher"
      this.marker = new mapboxgl.Marker(customMarker)
        .setLngLat([ start_marker.lng, start_marker.lat ])
        .addTo(this.map)
      markArray.push(this.marker)
    })
    if (n == 40) {
        clearInterval(interval)
      }
  }
}
