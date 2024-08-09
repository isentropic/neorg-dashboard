<img width="1234" alt="image" src="https://github.com/user-attachments/assets/1124c118-7eb5-46b6-b91b-65a2353e1c70"># What this is?

Say you have a norg file full of todos or some other information
(currently watching only specs.norg), you can live watch the rendered webpage
(html) of the norg file in your browser. This is meant to act as a possible
start page (new tab) in your browser of choice. 

This script watches your norg file for changes and live-reloads the webpage.

# Installation and running
1. Install [julia](julialang.org)
2. Start julia
3. Install this package in julia via `]add https://github.com/isentropic/neorg-dashboard`
4. Exit julia and run `julia -e 'using NorgDashboard; watch_norg("specs.norg")'`

The content of specs.norg or anyother file should now be live updated in your browser
# Screenshot
![Screenshot](screenshot.png?raw=true "Screenshot")

