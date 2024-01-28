#define MAX_PLAYER_VEHICLES 5

enum E_VEHICLE {
    id,
    owner_name[32],
    model,
    color[2],
    Float:x,
    Float:y,
    Float:z,
    Float:fa,
    interior,
    world,
    vehicle
};
new vehicle_info[MAX_VEHICLES][E_VEHICLE];
new Iterator:player_vehicles[MAX_PLAYERS] < MAX_VEHICLES - 1 >;