import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["textarea", "commentList"]

    /* submit(event) {
        event.preventDefault();

        const username_ele = document.getElementById("username");

        if(!username_ele) {
            if(confirm("로그인 후에 사용 가능합니다.\n 지금 로그인 하시겠습니까?")) {
                location.href='/login';
                return
            }

            const submitBtn = event.submitter || this.element.querySelector('[type="submit"]');
            if (submitBtn) submitBtn.blur();

            return
        }

        const username=username_ele.textContent;

        const comment = this.textareaTarget.value.trim();

        if (comment === "") {
            alert("댓글을 써주세요");
            this.textareaTarget.focus();
            return;
        }

        const form = this.element;
        const commentable_id = form.querySelector('input[name="comment[commentable_id]"]').value;
        const commentable_type = form.querySelector('input[name="comment[commentable_type]"]').value;
        const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');


        fetch(`${form.action}.json`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "X-CSRF-Token": token
            },
            body: JSON.stringify({
                comment: { commentable_id: commentable_id, comment: comment,commentable_type:  commentable_type}
            })
        })
            .then(response => response.json())
            .then(data => {
                this.textareaTarget.value = "";

                const newComment = document.createElement("div");
                newComment.innerHTML = `<h5>${username}</h5><div class="comment">${this.nl2br(comment)}</div>`;
                this.commentListTarget.appendChild(newComment);

                // highlight 효과 적용
                this.highlight(newComment);
            });
    }  */

    // nl2br 함수
    nl2br(str, isXhtml = true) {
        const breakTag = isXhtml ? "<br />" : "<br>";
        return (str + "").replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, `$1${breakTag}$2`);
    }

    highlight(element) {
        const commentDiv = element.querySelector(".comment");
        if (!commentDiv) return;

        // fade-in 효과: 노란색 추가
        commentDiv.classList.add("highlight");

        // fade-out 효과: 2초 후 highlight 제거
        setTimeout(() => {
            commentDiv.classList.remove("highlight");
        }, 2000);
    }
}
