//Project: A Robot

//The village of Vernon Hills isn’t very big. It consists of 11 places with 14 roads between them
//It can be described with this array of roads:

const roads = [
    "Alice's House-Bob's House", "Alice's House-Cabin",
    "Alice's House-Post Office", "Bob's House-Town Hall",
    "Daria's House-Ernie's House", "Daria's House-Town Hall",
    "Ernie's House-Grete's House", "Grete's House-Farm",
    "Grete's House-Shop", "Marketplace-Farm",
    "Marketplace-Post Office", "Marketplace-Shop",
    "Marketplace-Town Hall", "Shop-Town Hall"
];

function buildGraph(places) {
    let graph = Object.create(null)
    function getPlaces(from, to) {
        if (graph[from] == null) {
            graph[from] = [to];
        } else {
            graph[from].push(to); //appends to graph
        }
    }
    for (let [from, to] of places.map(element => element.split("-"))) {
        getPlaces(from, to);
        getPlaces(to, from);
    }
    return graph;
}

const roadGraph = buildGraph(roads);
console.log(roadGraph);

class VillageState {
    constructor(place, parcels) {
        this.place = place;
        this.parcels = parcels;
    }
    move(destination) {
        if (!roadGraph[this.place].includes(destination)) {
            return this;
        } else {
            let parcels = this.parcels.map(p => {
                if (p.place != this.place) return p;
                return { place: destination, address: p.address };
            }).filter(p => p.place != p.address);
            return new VillageState(destination, parcels);
        }
    }
}

let first = new VillageState(
    "Post Office",
    [{ place: "Post Office", address: "Alice's House" }]
);
let next = first.move("Alice's House");
console.log(next.place); // → Alice's House 
console.log(next.parcels); // → [] 
console.log(first.place); // → Post Office

//Can prevent object from being changed by doing Object.freeze
let object1 = Object.freeze({ value: 5 });
object1.value = 10;
console.log(object1.value); // → 5

const mailRoute = [
    "Alice's House", "Cabin", "Alice's House", "Bob's House",
    "Town Hall", "Daria's House", "Ernie's House",
    "Grete's House", "Shop", "Grete's House", "Farm",
    "Marketplace", "Post Office"
];

function routeRobot(state, memory) {
    if (memory.length == 0) {
        memory = mailRoute;
    }
    return { direction: memory[0], memory: memory.slice(1) };
}


function findRoute(graph, from, to) {
    let work = [{ at: from, route: [] }];
    for (let i = 0; i < work.length; i++) {
        let { at, route } = work[i];
        for (let place of graph[at]) {
            if (place == to) return route.concat(place); if (!work.some(w => w.at == place)) {
                work.push({ at: place, route: route.concat(place) });
            }
        }
    }
}
