#include <YSI_Coding\y_hooks> 

#define MYSQL_HOST "localhost"
#define MYSQL_USER "root"
#define MYSQL_PASS ""
#define MYSQL_DB   ""

new MySQL:SQLDB;

hook OnGameModeInit() {

    mysql_log(ERROR | WARNING);

	SQLDB = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DB);
	if (mysql_errno(SQLDB)) {
		print("[SQL] Connection failed! Please check the connection settings...\a");
		SendRconCommand("exit");
		return 1;
	}
	else
    {
        print("\n----------------------------------");
        printf("[SQL] Conection %s Pass!!",MYSQL_DB);
        print("\n----------------------------------");
    }
	return 1;
}

hook OnGameModeExit() {
    if(SQLDB)
    mysql_close(SQLDB);
	return 1;
}
