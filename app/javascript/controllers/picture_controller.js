import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["image"]

    preview(event) {
        const file = event.target.files[0]
        if (!file) return

        this.imageTarget.src = URL.createObjectURL(file)
        this.imageTarget.style.display = "block"
        this.imageTarget.style.opacity = "1"
    }

    toggleDelete(event) {
        if (event.target.checked) {
            this.imageTarget.style.opacity = "0.4"
        } else {
            this.imageTarget.style.opacity = "1"
        }
    }
}
