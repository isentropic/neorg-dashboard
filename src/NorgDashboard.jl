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

        <style>
        h1 {
            font-size: 1em;
            color: #007bff;
            background-color: rgba(0, 123, 255, 0.1);
            padding: 0.5em;
            font-weight: bold;
            margin-top: 1em;
            margin-bottom: 1em;
            border-left: 5px solid #007bff;
            padding-left: 10px;
        }

        h2 {
            font-size: 1.4em;
            background-color: rgba(108, 117, 125, 0.1);
            padding: 0.5em;
            font-weight: semi-bold;
            margin-top: 0.3em;
            border-left: 5px solid #6c757d;
            padding-left: 10px;
        }

        h3 {
            font-size: 1.2em;
            padding: 0.5em;
            font-weight: normal;
            margin-top: 0.5em;
            border-left: 5px solid #28a745;
            padding-left: 10px;
        }

        /* Additional heading levels as needed */
        </style>
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
