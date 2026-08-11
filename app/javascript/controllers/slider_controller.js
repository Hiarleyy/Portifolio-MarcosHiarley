import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container", "counter", "dot", "progressCircle"]
  static values = { total: Number }

  connect() {
    this.totalSlides = this.totalValue || this.dotTargets.length || 1
    this.initSwiper()
  }

  disconnect() {
    if (this.swiper) {
      this.swiper.destroy(true, true)
    }
  }

  initSwiper() {
    if (typeof window.Swiper === "undefined") {
      setTimeout(() => this.initSwiper(), 100)
      return
    }

    const self = this

    this.swiper = new window.Swiper(this.containerTarget, {
      parallax: true,
      effect: "fade",
      fadeEffect: {
        crossFade: true
      },
      speed: 1000,
      autoplay: {
        delay: 6000,
        disableOnInteraction: false
      },
      on: {
        init(swiper) {
          self.updatePagination(swiper.activeIndex)
        },
        slideChange(swiper) {
          self.updatePagination(swiper.activeIndex)
        },
        autoplayTimeLeft(swiper, time, progress) {
          self.updateProgressRing(progress)
        }
      }
    })
  }

  updatePagination(activeIndex) {
    // Update counter text "01 / 04"
    if (this.hasCounterTarget) {
      const current = String(activeIndex + 1).padStart(2, "0")
      const total = String(this.totalSlides).padStart(2, "0")
      this.counterTarget.textContent = `${current} / ${total}`
    }

    // Update active dot class
    this.dotTargets.forEach((dot, index) => {
      if (index === activeIndex) {
        dot.classList.add("active")
      } else {
        dot.classList.remove("active")
      }
    })
  }

  updateProgressRing(progressRatio) {
    // progressRatio goes from 1 to 0 during delay
    const percentage = 1 - progressRatio
    const circumference = 2 * Math.PI * 10 // radius is 10
    const strokeDashoffset = circumference * (1 - percentage)

    this.progressCircleTargets.forEach((circle) => {
      circle.style.strokeDasharray = `${circumference}`
      circle.style.strokeDashoffset = `${strokeDashoffset}`
    })
  }

  prev() {
    if (this.swiper) {
      this.swiper.slidePrev()
    }
  }

  next() {
    if (this.swiper) {
      this.swiper.slideNext()
    }
  }

  goTo(event) {
    const index = parseInt(event.currentTarget.dataset.index, 10)
    if (this.swiper && !isNaN(index)) {
      this.swiper.slideTo(index)
    }
  }
}
