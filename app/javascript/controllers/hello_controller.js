import { Controller } from "@hotwired/stimulus"
import { Fancybox } from "@fancyapps/ui"

export default class extends Controller {
    connect() {
        Fancybox.bind('[data-fancybox="gallery"]', {})
    }
    disconnect() {
        // 컨트롤러가 해제될 때 Fancybox 인스턴스도 정리
        Fancybox.close()
        Fancybox.destroy()
    }
}

