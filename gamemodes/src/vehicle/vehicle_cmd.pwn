CMD:changespawnvehicle(playerid) {
    if (Iter_Count(player_vehicles[playerid]) == 0) {
        return SendClientMessage(playerid, -1, "You don't have your own vehicle");
    }

    new current_vehicleid = GetPlayerVehicleID(playerid);
    if (current_vehicleid == 0) {
        return SendClientMessage(playerid, -1, "You're not in a vehicle");
    }

    foreach (new vehicleid:player_vehicles[playerid]) {
        if (vehicleid == current_vehicleid) {
            SaveNewPosVehicle(playerid, vehicleid);
            printf("%i", vehicle_info[vehicleid][model]);
            SendClientMessage(playerid, -1, "Save new pos successful!");
            return 1;
        }
    }
    return SendClientMessage(playerid, -1, "This isn't your vehicle");

}

SaveNewPosVehicle(playerid, vehicleid) {
    GetVehiclePos(vehicleid, vehicle_info[vehicleid][x],
                  vehicle_info[vehicleid][y], vehicle_info[vehicleid][z]);
    GetVehicleZAngle(vehicleid, vehicle_info[vehicleid][fa]);
    SaveVehiclePlayer(playerid, vehicleid);
}