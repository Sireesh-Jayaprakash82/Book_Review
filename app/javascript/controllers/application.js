import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require_tree .