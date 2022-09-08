import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl';
var n = -0.0035
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
    interval = setInterval(this.#animateMarker.bind(this), 150);
  }
  #addStartMarkersToMap() {
    this.startMarkersValue.forEach((marker) => {
      new mapboxgl.Marker()//bleu
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(this.map)
    })
  }
  #addEndMarkersToMap() {
    this.endMarkersValue.forEach((marker) => {
      new mapboxgl.Marker({color: '#5df84c'}) //vert
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
    n += 0.0035
    markArray.forEach(element => { element.remove() });
    markArray = []
    checkArray = []
    const isFalse = (currentValue) => currentValue == false ;
    this.startMarkersValue.forEach((start_marker) => {
      const end_marker = this.endMarkersValue.find(em => em.school_id == start_marker.school_id)
      let has_moved = false
      if (Math.abs(end_marker.lat - start_marker.lat) > n) {
        has_moved = true
        if (end_marker.lat > start_marker.lat){
          start_marker.lat += n}
        else {
          start_marker.lat -= n}
      }
      else {
        start_marker.lat = end_marker.lat
      }
      if (Math.abs(end_marker.lng - start_marker.lng) > n) {
        has_moved = true
        if (end_marker.lng > start_marker.lng){
          start_marker.lng += n}
        else {
          start_marker.lng -= n}
      }
      else {
        start_marker.lng = end_marker.lng
      }
      checkArray.push(has_moved)
      if (has_moved) {
        this.marker = new mapboxgl.Marker({color: '#F84C4C'}) //rouge
          .setLngLat([ start_marker.lng, start_marker.lat ])
          .addTo(this.map)
        markArray.push(this.marker)}
      })
      if (checkArray.every(isFalse)) {
          clearInterval(interval)
        }
  }
}
