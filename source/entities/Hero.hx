package entities;

import firebrick.Assets;
import firebrick.two.Body;
import firebrick.two.Sprite;
import firebrick.two.Entity;

class Hero extends Entity {
    public var sprite:Sprite;
    public var body:Body;

    public var acceleration:Float;
    public var jumpStrength:Float;

    override function startup() {
        var data = Assets.entities["hero"];
        sprite = new Sprite(data["sprite"], x, y);
        body = new Body(x, y, Game.instance.currentCollisionData);

        body.maximumSpeed = data["speed"];
        body.gravity = data["gravity"];
        body.friction = data["friction"];
        acceleration = data["acceleration"];
        jumpStrength = data["jumpStrength"];
    }

    override function shutdown() {
    }

    override function update() {
        if (Raylib.isKeyDown(Raylib.Keys.A)) {
            body.accelerationX = -acceleration;
            sprite.direction = -1;
        } else if (Raylib.isKeyDown(Raylib.Keys.D)) {
            body.accelerationX = acceleration;
            sprite.direction = 1;
        } else {
            body.accelerationX = 0;
        }

        if (Raylib.isKeyPressed(Raylib.Keys.SPACE) && body.isCollidingBottom) {
            body.velocityY = -jumpStrength;
        }
    }

    override function fixedUpdate() {
        body.fixedUpdate();
        x = body.x;
        y = body.y;
    }

    override function render() {
        sprite.x = x;
        sprite.y = y;
        sprite.render();
    }
}