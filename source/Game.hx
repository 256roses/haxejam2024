import entities.Hero;
import Raylib;
import firebrick.two.Entity;
import entities.Factory;
import firebrick.two.CollisionData;
import firebrick.Assets;
import firebrick.Module;
import firebrick.two.Editor;
import firebrick.two.Room;
import firebrick.two.RoomCollection;

class Game extends Module {
    public static var instance:Game;

    public var factory:Factory;

    public var currentRoomCollection:RoomCollection;
    public var currentRoom:Room;
    public var currentCollisionData:CollisionData;
    public var currentEntities:Array<Entity> = [];

    public var hero:Hero;
    public var camera:Camera2D;

    public var snapShader:Shader;

    override function startup() {
        if(instance == null) instance = this;

        factory = new Factory();

        currentRoomCollection = Assets.scenes["content/world/scene1.json"];
        setCurrentRoom(currentRoomCollection.rooms[0]);

        Editor.currentRoomCollection = Assets.scenes["content/world/scene1.json"];
        Editor.currentRoomToPlay = currentRoom;

        camera = Camera2D.create(Vector2.create(320, 180), Vector2.create(hero.x, hero.y));

        snapShader = Raylib.loadShader('content/world/snap.vs', null);
    }

    override function shutdown() {
        Raylib.unloadShader(snapShader);
    }

    override function update() {
        if(Editor.setCurrentRoom) {
            setCurrentRoom(Editor.currentRoomToPlay);
            Editor.setCurrentRoom = false;
        }

        hero.update();
        for (entity in currentEntities) entity.update();
    }

    override function fixedUpdate() {
        hero.fixedUpdate();
        for (entity in currentEntities) entity.fixedUpdate();

        // camera
        var targetX = hero.x;
        var targetY = hero.y;
        camera.target = Vector2.create(Std.int(targetX), Std.int(targetY));
    }

    override function render() {
        Raylib.beginShaderMode(snapShader);
        Raylib.beginMode2D(camera);
        {
            currentRoom.renderBackground();
            currentRoom.renderSolids();
            hero.render();
            for (entity in currentEntities) entity.render();
            currentRoom.renderForeground();
        }
        Raylib.endMode2D();
        Raylib.endShaderMode();
    }

    function setCurrentRoom(room:Room) {
        currentRoom = null;
        currentRoom = room;
        currentCollisionData = new CollisionData(currentRoom.x, currentRoom.y, currentRoom.width, currentRoom.height, currentRoom.solids);
        currentCollisionData.gridSize = currentRoomCollection.gridsize;
        unloadEntities();
        loadEntities();
    }

    function loadEntities() {
        for (entity in currentRoom.entities) {
            if(entity.id == "hero") hero = new Hero(entity);
            else currentEntities.push(factory.createEntity(entity.id, entity));
        }
    }

    function unloadEntities() {
        for (entity in currentEntities) {
            currentEntities.remove(entity);
            entity = null;
        }
    }

    inline function lerp(v0:Float, v1:Float, t:Float):Float {
        return v0 + t * (v1 - v0);
    }
}