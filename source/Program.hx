import firebrick.App;

function main() {
    var app = new App({
        title: "HaxeJam 2024",
        display: {w: 640, h: 360},
        desktop: {w: 1280, h: 720},
        web: {w: 640, h: 360},
    });
    app.run(new Game());
}