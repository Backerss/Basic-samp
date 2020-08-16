stock saveplayer(playerid)
{
    new savesql[600];

    mysql_format(SQLDB, savesql, sizeof(savesql), "UPDATE `account` SET pCash = %i, pLevel = %i WHERE ID = %i",
        PlayerData[playerid][pCash],
        PlayerData[playerid][pLevel],
        PlayerData[playerid][pDBID]);
    mysql_tquery(SQLDB, savesql);

    mysql_format(SQLDB, savesql, sizeof(savesql), "UPDATE `account` SET pAdmin = %i, pSpawnPoint = %i, pSpawnPointHouse = %i WHERE ID = %i",
        PlayerData[playerid][pAdmin],
        PlayerData[playerid][pSpawnPoint],
        PlayerData[playerid][pSpawnPointHouse],
        PlayerData[playerid][pDBID]);
    mysql_tquery(SQLDB, savesql);

    mysql_format(SQLDB, savesql, sizeof(savesql), "UPDATE `account` SET pFaction = %i, pRanks = %i WHERE ID = %i",
        PlayerData[playerid][pFaction],
        PlayerData[playerid][pRanks],
        PlayerData[playerid][pDBID]);
    mysql_tquery(SQLDB, savesql);

    mysql_format(SQLDB, savesql, sizeof(savesql), "UPDATE `account` SET pSkin = %i WHERE ID = %i",
        GetPlayerSkin(playerid),
        PlayerData[playerid][pDBID]);
    mysql_tquery(SQLDB, savesql);

    return 1;
}