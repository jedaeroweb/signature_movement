import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-form"
export default class extends Controller {
    static targets = ["photo", "url"]

    submit(event) {
        const fileInput = this.photoTarget
        if (fileInput.files.length > 0) {
            const imgSize = fileInput.files[0].size

            if (imgSize > 1 * 1024 * 1024) {
                alert("첨부 이미지 파일은 1MB 이하여야 합니다.")
                event.preventDefault() // 폼 전송 막기
                return false
            }
        }

        const urlField = this.urlTarget
        const urlValue = urlField.value.trim()
        if (urlValue === "https://" || urlValue === "http://") {
            urlField.value = ""
        }
    }

    focusUrl() {
        const urlField = this.urlTarget
        if (urlField.value.trim() === "") {
            urlField.value = "https://"
        }
    }
}
