if (player getVariable ["A3PE_Enabled", false]) then {
  player setVariable ["A3PE_Enabled", false, [2,clientOwner]];

  systemChat "Performance Toggled OFF";
  [] spawn {
      sleep 0.5;
      {
        _x hideObject false;
      } forEach allUnits;
      {
        _x hideObject false;
      } forEach allDeadMen;
    };
} else {
  player setVariable ["A3PE_Enabled", true, [2,clientOwner]];
  systemChat "Performance Toggled ON";

  [] spawn {
    while {player getVariable ["A3PE_Enabled", false]} do {
      sleep 1;
      player setVariable ["A3PE_ViewDistance", viewDistance, [2,clientOwner]];
      player setVariable ["A3PE_ZeusCameraPos", (getPosASL curatorCamera), [2,clientOwner]];
      player setVariable ["A3PE_IsConnectedUav", UAVControl (getConnectedUAV player), [2,clientOwner]];
      player setVariable ["A3PE_ShownUAVFeed", shownUAVFeed, [2,clientOwner]];
      player setVariable ["A3PE_ForceRenderDistance", ForceRenderDistance, [2,clientOwner]];
      player setVariable ["A3PE_HigherQualityAI", HigherQualityAI, [2,clientOwner]];
      player setVariable ["A3PE_HigherQualityDead", HigherQualityDead, [2,clientOwner]];
      player setVariable ["A3PE_EnablePlayerHide", EnablePlayerHide, [2,clientOwner]];
      player setVariable ["A3PE_HigherQualityPlayer", HigherQualityPlayer, [2,clientOwner]];
    }; // While Loop
  }; // Spawn
}; // If Statement
