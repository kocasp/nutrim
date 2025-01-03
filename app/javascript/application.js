// app/javascript/application.js

// Import jQuery first and make it globally available
import $ from 'jquery'
window.$ = $
window.jQuery = $

// Import Fancybox CSS and JS
import '@fancyapps/fancybox/dist/jquery.fancybox.css'
import '@fancyapps/fancybox'

// Import other required libraries that main.js depends on
import Swup from 'swup'
window.Swup = Swup

import { gsap } from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'
import { ScrollToPlugin } from 'gsap/ScrollToPlugin'
window.gsap = gsap
window.ScrollTrigger = ScrollTrigger
window.ScrollToPlugin = ScrollToPlugin

import Swiper from 'swiper'
window.Swiper = Swiper

// Import Rails specific libraries
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

// Import main.js after all dependencies are loaded
import "./main"