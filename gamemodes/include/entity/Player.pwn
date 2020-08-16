new bool:PlayerLogin[MAX_PLAYERS];

enum P_PLAYER_DATA
{
    pDBID,
    pName[60],
    pSkin,
    pCash,
    pLevel,
    pPassword[266],


    pAdmin,
    pSpawnPoint,
    pSpawnPointHouse,
    pFaction,
    pRanks,

};
new PlayerData[MAX_PLAYERS][P_PLAYER_DATA];