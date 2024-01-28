#include <YSI_Coding\y_hooks>

new Statement:stmt_insertVehiclePlayer;
new Statement:stmt_loadVehiclePlayer;
new Statement:stmt_saveVehiclePlayer;

hook OnGameModeInit() {
    stmt_insertVehiclePlayer = MySQL_PrepareStatement(MySQL_Handle, "INSERT INTO vehicle (ownerName, model, color, x, y, z, fa, interior, world) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
    stmt_loadVehiclePlayer = MySQL_PrepareStatement(MySQL_Handle, "SELECT * FROM vehicle WHERE ownerName = ?");
    stmt_saveVehiclePlayer = MySQL_PrepareStatement(MySQL_Handle, "UPDATE vehicle SET ownerName = ?, model = ?, color = ?, x = ?, y = ?, z = ?, fa = ?, interior = ?, world = ? WHERE id = ?");
    return 1;
}

CreateVehiclePlayer(playerid, vehicleid) {
    ExecuteInsertVehiclePlayer(playerid, vehicleid);
}

LoadVehicleByOwnerName(playerid) {
    ExecuteLoadVehiclePlayer(playerid);
}

SaveVehiclePlayerData(playerid, vehicleid) {
    ExecuteSaveVehiclePlayer(playerid, vehicleid);
}

BindParamsInsertVehiclePlayer(playerid, vehicleid) {
    MySQL_BindPlayerName(stmt_insertVehiclePlayer, 0, playerid);
    MySQL_BindInt(stmt_insertVehiclePlayer, 1, vehicle_info[vehicleid][model]);
    MySQL_Bind(stmt_insertVehiclePlayer, 2, sprintf("%i, %i", vehicle_info[vehicleid][color][0], vehicle_info[vehicleid][color][1]));
    MySQL_BindFloat(stmt_insertVehiclePlayer, 3, vehicle_info[vehicleid][x]);
    MySQL_BindFloat(stmt_insertVehiclePlayer, 4, vehicle_info[vehicleid][y]);
    MySQL_BindFloat(stmt_insertVehiclePlayer, 5, vehicle_info[vehicleid][z]);
    MySQL_BindFloat(stmt_insertVehiclePlayer, 6, vehicle_info[vehicleid][fa]);
    MySQL_BindInt(stmt_insertVehiclePlayer, 7, vehicle_info[vehicleid][interior]);
    MySQL_BindInt(stmt_insertVehiclePlayer, 8, vehicle_info[vehicleid][world]);
}

BindParamsSaveVehiclePlayer(playerid, vehicleid) {
    MySQL_BindPlayerName(stmt_saveVehiclePlayer, 0, playerid);
    MySQL_BindInt(stmt_saveVehiclePlayer, 1, vehicle_info[vehicleid][model]);
    MySQL_Bind(stmt_saveVehiclePlayer, 2, sprintf("%i, %i", vehicle_info[vehicleid][color][0], vehicle_info[vehicleid][color][1]));
    MySQL_BindFloat(stmt_saveVehiclePlayer, 3, vehicle_info[vehicleid][x]);
    MySQL_BindFloat(stmt_saveVehiclePlayer, 4, vehicle_info[vehicleid][y]);
    MySQL_BindFloat(stmt_saveVehiclePlayer, 5, vehicle_info[vehicleid][z]);
    MySQL_BindFloat(stmt_saveVehiclePlayer, 6, vehicle_info[vehicleid][fa]);
    MySQL_BindInt(stmt_saveVehiclePlayer, 7, vehicle_info[vehicleid][interior]);
    MySQL_BindInt(stmt_saveVehiclePlayer, 8, vehicle_info[vehicleid][world]);
    MySQL_BindInt(stmt_saveVehiclePlayer, 9, vehicle_info[vehicleid][id]);
}



ExecuteInsertVehiclePlayer(playerid, vehicleid) {
    inline const OnInsertVehicleResult() {
        vehicle_info[vehicleid][id] = cache_insert_id();
        Iter_Add(player_vehicles[playerid], vehicle_info[vehicleid][vehicle]) ;
        print("Success insert vehicle");
    }
    BindParamsInsertVehiclePlayer(playerid, vehicleid);
    MySQL_ExecuteThreaded_Inline(stmt_insertVehiclePlayer, using inline OnInsertVehicleResult);
}

ExecuteLoadVehiclePlayer(playerid) {
    MySQL_BindPlayerName(stmt_loadVehiclePlayer, 0, playerid);
    inline const OnVehicleLoad() {
        new vehicleid = GetVehicleID();
        new temp_string[10];
        new vehid, temp_owner_name[32], temp_model, temp_colors[2][1], Float:pos_x, Float:pos_y, Float:pos_z,
        Float:pos_fa, temp_world, temp_interior;
        MySQL_BindResultInt(stmt_loadVehiclePlayer, 0, vehid);
        MySQL_BindResult(stmt_loadVehiclePlayer, 1, temp_owner_name, 32);
        MySQL_BindResultInt(stmt_loadVehiclePlayer, 2, temp_model);
        MySQL_Bind(stmt_loadVehiclePlayer, 3, temp_string);
        MySQL_BindResultFloat(stmt_loadVehiclePlayer, 4, pos_x);
        MySQL_BindResultFloat(stmt_loadVehiclePlayer, 5, pos_y);
        MySQL_BindResultFloat(stmt_loadVehiclePlayer, 6, pos_z);
        MySQL_BindResultFloat(stmt_loadVehiclePlayer, 7, pos_fa);
        MySQL_BindResultInt(stmt_loadVehiclePlayer, 8, temp_interior);
        MySQL_BindResultInt(stmt_loadVehiclePlayer, 9, temp_world);

        while (MySQL_Statement_FetchRow(stmt_loadVehiclePlayer)) {
            vehicle_info[vehicleid][id] = vehid;
            strcat(vehicle_info[vehicleid][owner_name], temp_owner_name);
            vehicle_info[vehicleid][model] = temp_model;

            strexplode(temp_colors, temp_string, ", ");
            vehicle_info[vehicleid][color][0] = strval(temp_colors[0]);
            vehicle_info[vehicleid][color][1] = strval(temp_colors[1]);

            vehicle_info[vehicleid][x] = pos_x;
            vehicle_info[vehicleid][y] = pos_y;
            vehicle_info[vehicleid][z] = pos_z;
            vehicle_info[vehicleid][fa] = pos_fa;
            vehicle_info[vehicleid][world] = temp_world;
            vehicle_info[vehicleid][interior] = temp_interior;
            vehicle_info[vehicleid][vehicle] = CreateVehicle(vehicle_info[vehicleid][model],
                                               vehicle_info[vehicleid][x], vehicle_info[vehicleid][y],
                                               vehicle_info[vehicleid][z], vehicle_info[vehicleid][fa],
                                               vehicle_info[vehicleid][color][0], vehicle_info[vehicleid][color][1], 600) ;
            Iter_Add(player_vehicles[playerid], vehicle_info[vehicleid][vehicle]) ;
            vehicleid++;
        }
    }
    MySQL_ExecuteThreaded_Inline(stmt_loadVehiclePlayer, using inline OnVehicleLoad);
}

ExecuteSaveVehiclePlayer(playerid, vehicleid) {
    inline const OnSaveVehicleResult() {
        print("Success save vehicle");
    }
    BindParamsSaveVehiclePlayer(playerid, vehicleid);
    MySQL_ExecuteThreaded_Inline(stmt_saveVehiclePlayer, using inline OnSaveVehicleResult);
}
