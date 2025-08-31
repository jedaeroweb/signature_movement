import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap"

export default class extends Controller {
    static targets = ["modal"]

    connect() {
    }

    open(event) {
        event.preventDefault()

        const url = event.currentTarget.getAttribute('href')
        const modalUrl = url + (url.includes('?') ? '&popup=true' : '?popup=true')

        const container = document.getElementById('myModal')


        fetch(modalUrl)
            .then(response => response.text())
            .then(html => {
                container.innerHTML = html
                    const modal = new Modal(container)
                    modal.show();

            })
    }
}
