import { Controller } from "@hotwired/stimulus"

// Replicates the MagneticDots canvas animation from the reference
// "sobre mim dotteed" component — pure vanilla JS / Canvas 2D.
export default class extends Controller {
  static values = {
    dotSize:           { type: Number, default: 1.5 },
    dotSpacing:        { type: Number, default: 28 },
    attractionRadius:  { type: Number, default: 160 },
    attractionStrength:{ type: Number, default: 0.3 },
    springStrength:    { type: Number, default: 0.05 },
    damping:           { type: Number, default: 0.85 },
    dotColor:          { type: String, default: "rgba(160, 160, 160, 0.35)" },
    flowAngle:         { type: Number, default: 25 },
    flowSpeed:         { type: Number, default: 0.02 },
    flowAmplitude:     { type: Number, default: 15 },
  }

  connect() {
    this._canvas = document.createElement("canvas")
    this._canvas.style.cssText =
      "position:absolute;inset:0;width:100%;height:100%;pointer-events:none;z-index:0;"
    this._canvas.setAttribute("aria-hidden", "true")
    this.element.style.position = "relative"
    this.element.prepend(this._canvas)

    this._ctx   = this._canvas.getContext("2d")
    this._dots  = []
    this._mouse = { x: -1000, y: -1000 }
    this._time  = 0
    this._raf   = null

    this._resize      = this._resize.bind(this)
    this._onMouseMove = this._onMouseMove.bind(this)
    this._onMouseLeave = this._onMouseLeave.bind(this)
    this._animate     = this._animate.bind(this)

    window.addEventListener("resize", this._resize)
    this.element.addEventListener("mousemove", this._onMouseMove)
    this.element.addEventListener("mouseleave", this._onMouseLeave)

    this._resize()
    this._animate()
  }

  disconnect() {
    window.removeEventListener("resize", this._resize)
    this.element.removeEventListener("mousemove", this._onMouseMove)
    this.element.removeEventListener("mouseleave", this._onMouseLeave)
    if (this._raf) cancelAnimationFrame(this._raf)
    this._canvas.remove()
  }

  // ── Private ──────────────────────────────────────────────

  _resize() {
    const parent = this.element
    this._canvas.width  = parent.clientWidth  || window.innerWidth
    this._canvas.height = parent.clientHeight || window.innerHeight
    this._initDots()
  }

  _initDots() {
    const { width, height } = this._canvas
    const spacing  = this.dotSpacingValue
    const angleRad = (this.flowAngleValue * Math.PI) / 180
    const dots     = []

    const cols = Math.ceil((width  + height * Math.abs(Math.tan(angleRad))) / spacing) + 2
    const rows = Math.ceil((height + width  * Math.abs(Math.tan(angleRad))) / spacing) + 2

    for (let i = 0; i < cols; i++) {
      for (let j = 0; j < rows; j++) {
        const x = i * spacing - j * spacing * Math.sin(angleRad)
        const y = j * spacing

        if (
          x > -spacing * 2 && x < width  + spacing * 2 &&
          y > -spacing * 2 && y < height + spacing * 2
        ) {
          dots.push({ x, y, baseX: x, baseY: y, vx: 0, vy: 0, flowOffset: (i + j) * 0.5 })
        }
      }
    }
    this._dots = dots
  }

  _onMouseMove(e) {
    const rect = this._canvas.getBoundingClientRect()
    this._mouse = { x: e.clientX - rect.left, y: e.clientY - rect.top }
  }

  _onMouseLeave() {
    this._mouse = { x: -1000, y: -1000 }
  }

  _animate() {
    const ctx    = this._ctx
    const canvas = this._canvas
    ctx.clearRect(0, 0, canvas.width, canvas.height)

    this._time += this.flowSpeedValue

    const dotSize           = this.dotSizeValue
    const attractionRadius  = this.attractionRadiusValue
    const attractionStrength= this.attractionStrengthValue
    const springStrength    = this.springStrengthValue
    const damping           = this.dampingValue
    const dotColor          = this.dotColorValue
    const flowAmplitude     = this.flowAmplitudeValue

    const mouseX = this._mouse.x
    const mouseY = this._mouse.y
    const t      = this._time

    for (const dot of this._dots) {
      const flowX = Math.sin(t + dot.flowOffset) * flowAmplitude
      const flowY = Math.cos(t + dot.flowOffset * 0.7) * (flowAmplitude * 0.5)

      const targetX = dot.baseX + flowX
      const targetY = dot.baseY + flowY

      const dx   = mouseX - dot.x
      const dy   = mouseY - dot.y
      const dist = Math.sqrt(dx * dx + dy * dy)

      if (dist < attractionRadius && dist > 0) {
        const norm  = dist / attractionRadius
        const force = (1 - norm) * attractionStrength * 2.0
        dot.vx += (dx / dist) * force
        dot.vy += (dy / dist) * force
      }

      dot.vx += (targetX - dot.x) * springStrength
      dot.vy += (targetY - dot.y) * springStrength

      dot.vx *= damping
      dot.vy *= damping

      dot.x += dot.vx
      dot.y += dot.vy

      ctx.fillStyle = dotColor
      ctx.beginPath()
      ctx.arc(dot.x, dot.y, dotSize, 0, Math.PI * 2)
      ctx.fill()
    }

    this._raf = requestAnimationFrame(this._animate)
  }
}
