// app/javascript/controllers/login_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        // 페이지 로드 시 체크박스 해제
        this.element.checked = false
    }

    handleRememberMe(event) {
        if (this.element.checked) {
            const confirmed = confirm("1달간 로그인이 유지 됩니다. 공공장소 PC에서 사용 주의\n  로그인 정보 기억하시겠습니까?")
            if (!confirmed) {
                this.element.checked = false
            }
        }
    }
}
