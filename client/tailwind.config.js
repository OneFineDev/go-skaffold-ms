/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './templates/**/**/*.templ',
    './public/assets/dist/preline/dist/*.js'
  ],
  darkMode: 'class',
  plugins: [
    require('preline/plugin')
  ],

}
