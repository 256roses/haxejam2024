# HaxeJam 2024
This repo was made before **HaxeJam Summer 2024** so that I can set everything up before the actual jam started.
The game utilizes a custom framework and editor, every image file uses the aseprite file format (`.ase`).

### Build Instructions
To *setup* the project, run the following commands in the directory of this repository
```
haxelib newrepo
haxelib install hxcpp
haxelib dev firebrick vendor/firebrick
haxelib dev ase vendor/ase
haxelib dev raylib-hx vendor/raylib-hx
```

and to *build* the project

For desktop:
```
haxe build.cpp.hxml
```

For web:
> ! It is to be noted that the generated html for the wasm build is not the one used in the final build of the game.
```
haxe build.wasm.hxml
```

### Libraries
The third-party libraries used include
- [raysan5/raylib](https://www.github.com/raysan5/raylib) for all the rendering
- [miriti/ase](https://github.com/miriti/ase) for loading aseprite files