import { Controller } from "@hotwired/stimulus"
import CalHeatmap from "cal-heatmap"
import Tooltip from "cal-heatmap/plugins/Tooltip"
import LegendLite from "cal-heatmap/plugins/LegendLite"

export default class extends Controller {
  static values = { url: String }

  connect() {
    this.heatmap = new CalHeatmap()
    this.heatmap.paint(
      {
        itemSelector: this.element,
        range: 12,
        domain: { type: "month", gutter: 4 },
        subDomain: { type: "day", radius: 2, width: 11, height: 11 },
        data: { source: this.urlValue, type: "json", x: "date", y: "value" },
        scale: {
          color: {
            scheme: "Reds",
            type: "linear",
            domain: [0, 4],
          },
        },
      },
      [
        [Tooltip, { text: (_date, value) => `${value || 0} event(s)` }],
        [LegendLite, { includeBlank: true }],
      ],
    )
  }

  disconnect() {
    this.heatmap?.destroy()
  }
}