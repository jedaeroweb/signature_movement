import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["count", "icon"]

    async vote(event) {
        event.preventDefault()

        // 이미 투표했는지 확인
        if (this.iconTarget.classList.contains('already-vote')) {
            alert('이미 투표하셨습니다.')
            return
        }

        const url = `${event.currentTarget.getAttribute('href')}.json`

        try {
            const response = await fetch(url, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
                },
                body: JSON.stringify({
                    _method: 'put'
                })
            })

            const data = await response.json()

            if (data.vote_up) {
                this.iconTarget.classList.add('already-vote')
                this.countTarget.textContent = ` ${data.vote_up}`
            }
        } catch (error) {
            console.error('투표 처리 중 오류가 발생했습니다:', error)
        }
    }
}
