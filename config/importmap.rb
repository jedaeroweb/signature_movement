# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "rails-ujs", to: "rails-ujs.js"
pin "trix"
pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.8/dist/esm/index.js" # Popper.js 추가
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.3.2/dist/js/bootstrap.esm.js" # Bootstrap ESM 버전으로 변경
pin "@fancyapps/ui", to: "https://cdn.jsdelivr.net/npm/@fancyapps/ui/dist/fancybox.esm.js"
pin "common", to: "common.js"
pin "@rails/actiontext", to: "actiontext.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
