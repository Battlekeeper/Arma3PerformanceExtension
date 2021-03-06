if (player getVariable ["A3PE_Enabled", false]) then {
  _HCNetworkID = missionNamespace getVariable ["A3PE_HCNetworkID", clientOwner];
  player setVariable ["A3PE_Enabled", false, [2,clientOwner,_HCNetworkID]];

  systemChat "Performance Toggled OFF";
  [] spawn {
      sleep 0.5;
      {
        _x hideObject false;
      } forEach allUnits;
      {
        _x hideObject false;
      } forEach allDeadMen;
      {
        _x hideObject false;
      } forEach allPlayers;
      {
        _x hideObject false;
      } forEach vehicles;
    };
} else {
  _HCNetworkID = missionNamespace getVariable ["A3PE_HCNetworkID", clientOwner];
  player setVariable ["A3PE_Enabled", true, [2,clientOwner,_HCNetworkID]];
  systemChat "Performance Toggled ON";

  [] spawn {
    while {player getVariable ["A3PE_Enabled", false]} do {
      sleep 1;
      _HCNetworkID = missionNamespace getVariable ["A3PE_HCNetworkID", clientOwner];
      player setVariable ["A3PE_ViewDistance", viewDistance, [2,clientOwner,_HCNetworkID]];
      player setVariable ["A3PE_ZeusCameraPos", (getPosASL curatorCamera), [2,clientOwner,_HCNetworkID]];
      player setVariable ["A3PE_IsConnectedUav", UAVControl (getConnectedUAV player), [2,clientOwner,_HCNetworkID]];
      player setVariable ["A3PE_ShownUAVFeed", shownUAVFeed, [2,clientOwner,_HCNetworkID]];
      player setVariable ["A3PE_ForceRenderDistance", ForceRenderDistance, [2,clientOwner,_HCNetworkID]];
      player setVariable ["A3PE_HigherQualityAI", HigherQualityAI, [2,clientOwner,_HCNetworkID]];
      player setVariable ["A3PE_HigherQualityDead", HigherQualityDead, [2,clientOwner,_HCNetworkID]];
      player setVariable ["A3PE_EnablePlayerHide", EnablePlayerHide, [2,clientOwner,_HCNetworkID]];
      player setVariable ["A3PE_HigherQualityPlayer", HigherQualityPlayer, [2,clientOwner,_HCNetworkID]];
      player setVariable ["A3PE_HigherQualityVehicles", HigherQualityVehicles, [2,clientOwner,_HCNetworkID]];
      player setVariable ["A3PE_EnableVehicleHide", EnableVehicleHide, [2,clientOwner,_HCNetworkID]];
      player setVariable ["A3PE_EnableDeadHide", EnableDeadHide, [2,clientOwner,_HCNetworkID]];
      player setVariable ["A3PE_EnableAIHide", EnableAIHide, [2,clientOwner,_HCNetworkID]];
    }; // While Loop
  }; // Spawn
}; // If Statement
