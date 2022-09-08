import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl';

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
    setInterval(this.#animateMarker.bind(this), 1000);
  }
  #addStartMarkersToMap() {
    console.log("bleu")
    console.log(this.startMarkersValue)
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
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  #animateMarker() {
    // if ((Math.abs(start_marker.lat - end_marker.lat) > 0.011) && (Math.abs(start_marker.lng - end_marker.lng)) > 0.011) {
      console.log("rougeHELL")
    this.startMarkersValue.forEach((start_marker) => {
      const end_marker = this.endMarkersValue.find(em => em.school_id == start_marker.school_id)
      if (Math.abs(start_marker.lat - end_marker.lat) > 0.011) {
        start_marker.lat = [end_marker.lat - (Math.abs(end_marker.lat - start_marker.lat) + 0.01) ]}
      if (Math.abs(start_marker.lng - end_marker.lng) > 0.011)  {
        start_marker.lng = [end_marker.lng - (Math.abs(end_marker.lng - start_marker.lng) + 0.01) ]}

      });

    this.startMarkersValue.forEach((marker) => {
      new mapboxgl.Marker({color: '#F84C4C'}) //rouge
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(this.map)
      });
    //requestAnimationFrame(this.#animateMarker);
  }
}
