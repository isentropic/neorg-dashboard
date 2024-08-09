module NorgDashboard

using LiveServer: serve
using Norg: norg, HTMLTarget
using BetterFileWatching: watch_file



function export_to_html(filename, temp_dir)
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
      </head>
      <body>
        <div class="container">
        $norg_filecontent
        </div>
      </body>
    </html>
    """
    open(joinpath(temp_dir, "index.html"), "w") do io
        write(io, index_html)
    end
end


# Write your package code here.
#
function watch_norg(filename)
    filename = abspath(filename)
    temp_dir = mktempdir()
    cd(temp_dir)

    export_to_html(filename, temp_dir)
    watch_task = @async watch_file(filename) do event
        @info "File changed!"
        try
            export_to_html(filename, temp_dir)
        catch e
            @info "couldn't export to html"
        end
    end
    serve(launch_browser=true)
end

export watch_norg
end
