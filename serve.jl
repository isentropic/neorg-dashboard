import Pkg
Pkg.instantiate()
using LiveServer
using Norg
using BetterFileWatching


filename = "specs.norg"

cd("example")
filename = joinpath("..", filename)

function export_to_html(filename)
    file_contents = open(filename, "r") do file
        read(file, String)  # Read the entire file content as a String
    end
    norg_filecontent = string(norg(HTMLTarget(), file_contents))

    index_html = """
    <!DOCTYPE html>
    <html lang="en" dir="ltr">
      <head>
        <meta charset="utf-8">
        <title>Live-Server Test</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <!-- <link rel="stylesheet" href="/css/master.css"> -->
      </head>
      <body>
        <div class="container">
        $norg_filecontent
        </div>
      </body>
    </html>
    """
    open("index.html", "w") do io
        write(io, index_html)
    end
end

export_to_html(filename)
watch_task = @async watch_file(filename) do event
    @info "Something changed!"
    @info event
    try
        export_to_html(filename)
    catch e
        @info "couldn't export"
    end
end

serve(launch_browser=true)

