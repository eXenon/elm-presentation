# Elm Workshop presentation


To generate an empty Elm project :
```
$ docker run -it -v $(pwd):/code/ -w /code/ -u "$UID:$GID" codesimple/elm:0.19 init
```

To compile a project to a single HTML output :
```
$ docker run -v $(pwd):/code/ -w /code/ -u "$UID:$GID" codesimple/elm:0.19 make src/main.elm --output=index.html --debug
```

To execute the output, start a server on port 8000 :
```
$ python3 -m http.server
```

##### Note

Using the Docker, I had several problems regarding corrupted elm-stuff/ folders. Simply `rm -rf` the folder and recompile.
