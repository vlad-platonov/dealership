#include <YSI_Coding\y_hooks>

new MySQL: MySQL_Handle;

hook OnGameModeInit() {
    new MYSQL_HOST[32];
    new MYSQL_USER[32];
    new MYSQL_PASSWORD[32];
    new MYSQL_DATABASE[32];

    if(!Env_Has("MYSQL_HOST")) {
        printf("ERROR: MYSQL_HOST is empty");
        SendRconCommand("exit");
    }
    Env_Get("MYSQL_HOST", MYSQL_HOST);

    if(!Env_Has("MYSQL_USER")) {
        printf("ERROR: MYSQL_USER is empty");
        SendRconCommand("exit");
    }
    Env_Get("MYSQL_USER", MYSQL_USER);

    if(!Env_Has("MYSQL_PASSWORD")) {
        printf("ERROR: MYSQL_PASSWORD is empty");
        SendRconCommand("exit");
    }
    Env_Get("MYSQL_PASSWORD", MYSQL_PASSWORD);

    if(!Env_Has("MYSQL_DATABASE")) {
        printf("ERROR: MYSQL_DATABASE is empty");
        SendRconCommand("exit");
    }
    Env_Get("MYSQL_DATABASE", MYSQL_DATABASE);

    MySQL_Handle = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE);

    if(mysql_errno() != 0) {
        printf("ERROR: MySQL could not connect to database!");
        SendRconCommand("exit");
    }
    return 1;
}

hook OnGameModeExit() {
    mysql_close(MySQL_Handle);
    return 1;
}