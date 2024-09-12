# Pin npm packages by running ./bin/importmap
# config/importmap.rb

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
# pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "bootstrap.min.js"
pin "bootstrap/dist/css/bootstrap.min.css", to: "bootstrap.min.css"
pin "bootstrap", to: "bootstrap.bundle.min.js"
pin "bootstrap/dist/css/bootstrap", to: "bootstrap.min.css"
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.3.1/dist/js/bootstrap.esm.js"
pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.7/lib/index.js"

