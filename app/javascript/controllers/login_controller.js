// app/javascript/controllers/login_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["noSnsLogin","snsLogin","noSnsIdParent"]
    connect() {
        // 페이지 로드 시 체크박스 해제
        const checkbox = this.element.querySelector('input[type="checkbox"]')
        if (checkbox) checkbox.checked = false
    }

    toggle() {
        this.noSnsLoginTarget.classList.remove('d-none')
        this.snsLoginTarget.classList.add('d-none')
        this.noSnsIdParentTarget.classList.add('d-none')
    }


    handleRememberMe(event) {
        if (event.target.checked) {
            const confirmed = confirm("1달간 로그인이 유지 됩니다. 공공장소 PC에서 사용 주의\n  로그인 정보 기억하시겠습니까?")
            if (!confirmed) {
                event.target.checked = false
            }
        }
    }
}
