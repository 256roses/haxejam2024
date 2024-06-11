package entities;

import firebrick.two.RoomSerializables;
import firebrick.two.Entity;

typedef EntityFactory = EntityData->Entity;

class Factory {
    public var entityRegister:Map<String, EntityFactory> = [];

    public function new() {
        registerEntityType('hero', Hero.new);
    }

    public function registerEntityType<T:Entity>(name:String, factory:EntityFactory) {
        entityRegister[name] = factory;
    }

    public function createEntity(name:String, data:EntityData) {
        var factory = entityRegister[name];
        return factory(data);
    }

    public function getAllNames():Array<String> {
        var a:Array<String> = [];
        for(k => v in entityRegister) a.push(k);
        return a;
    }
}