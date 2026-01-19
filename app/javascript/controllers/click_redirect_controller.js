// controllers/click_redirect_controller.js
import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

export default class extends Controller {
    static targets = ["row", "media"]

    connect() {
        this.element.style.cursor = "pointer"
    }

    rowClick(event) {
        const link = event.currentTarget.querySelector("a:first-child")
        if (link) {
            Turbo.visit(link.getAttribute("href"))
        }
    }


    mediaClick(event) {
        // 클릭한 곳이 링크면 그냥 통과
        const closestLink = event.target.closest("a");
        if (closestLink) return; // 링크 클릭 자체는 default 동작

        // 전체 article 클릭 시 첫 번째 링크를 찾아 이동
        const firstLink = this.element.querySelector("a");
        if (firstLink) {
            Turbo.visit(firstLink.getAttribute("href"));
        }
    }

}

