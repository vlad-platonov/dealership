#include <YSI_Coding\y_hooks>
hook OnGameModeInit() {
    Iter_Init(player_vehicles);
}

hook OnPlayerConnect(playerid) {
    LoadVehicleByOwnerName(playerid);
}

hook OnPlayerDisconnect(playerid, reason) {
    DestroyPlayerVehicles(playerid);
}

SaveVehiclePlayer(playerid, vehicleid) {
    SaveVehiclePlayerData(playerid, vehicleid);
}

GetVehicleID() {
    new vehicleid = AddStaticVehicleEx(400, -100, -100, -100, 0, 0, 0, 0);
    DestroyVehicle(vehicleid);
    return vehicleid;
}

DestroyPlayerVehicles(playerid) {
    if (Iter_Count(player_vehicles[playerid]) != 0) {
        foreach (new vehicleid:player_vehicles[playerid]) {
            DestroyVehicle(vehicleid);
        }
        Iter_Clear(player_vehicles[playerid]);
    }
}
