#include "\a3\ui_f\hpp\definedikcodes.inc"

["ForceRenderDistance","SLIDER",["Force Render Range in Meters","Range at which units are force rendered, units in this range will be rendered even if you cannot see them."],["Arma 3 Performance Settings","Arma 3 Performance Settings"],[0, 500, 10, 0],0,{},false] call CBA_fnc_addSetting;
["EnableAIHide","CHECKBOX",["Enable The Hiding of AI","Enable the Hiding of AI"],["Arma 3 Performance Settings","Arma 3 Performance Settings"],true,0,{},false] call CBA_fnc_addSetting;
["EnableDeadHide","CHECKBOX",["Enable The Hiding of Dead Bodies","Enable the Hiding of Dead Bodies"],["Arma 3 Performance Settings","Arma 3 Performance Settings"],true,0,{},false] call CBA_fnc_addSetting;
["EnablePlayerHide","CHECKBOX",["Enable The Hiding of Players","Enable the Hiding of Players"],["Arma 3 Performance Settings","Arma 3 Performance Settings"],false,0,{},false] call CBA_fnc_addSetting;
["EnableVehicleHide","CHECKBOX",["Enable The Hiding of Vehicles","Enable the Hiding of Vehicles"],["Arma 3 Performance Settings","Arma 3 Performance Settings"],false,0,{},false] call CBA_fnc_addSetting;

["EnableHCOverride","CHECKBOX",["Enable Headless Clients - Requires Mission Restart","Enables the mod to run calculations on headless clients rather than the server, improves server FPS"],["Arma 3 Performance Settings","Headless Client Settings"],false,1,{},true] call CBA_fnc_addSetting;

["HigherQualityAI","CHECKBOX",["Enable Lower Latency For AI","Enables extra calculations to decrease latency when turning a corner, can decrease server FPS"],["Arma 3 Performance Settings","Higher Quality Settings - May Affect Server FPS"],false,1,{},false] call CBA_fnc_addSetting;
["HigherQualityDead","CHECKBOX",["Enable Lower Latency For Dead Bodies","Enables extra calculations to decrease latency when turning a corner, can decrease server FPS"],["Arma 3 Performance Settings","Higher Quality Settings - May Affect Server FPS"],false,1,{},false] call CBA_fnc_addSetting;
["HigherQualityPlayer","CHECKBOX",["Enable Lower Latency For players","Enables extra calculations to decrease latency when turning a corner, can decrease server FPS"],["Arma 3 Performance Settings","Higher Quality Settings - May Affect Server FPS"],false,1,{},false] call CBA_fnc_addSetting;

if (!isDedicated && hasInterface) then {
  ["Toggle Performance Enhance", "Toggle_Performance", "Toggle Performance Enhance", {_this call A3PE_fnc_toggle}, {}, [DIK_U, [false, false, false]],false,0,true] call cba_fnc_addKeybind;
  _HCNetworkID = missionNamespace getVariable ["A3PE_HCNetworkID", clientOwner];
  player setVariable ["A3PE_Enabled", false, [2,clientOwner,_HCNetworkID]];
  player setVariable ["A3PE_ViewDistance", viewDistance, [2,clientOwner,_HCNetworkID]];
  player setVariable ["A3PE_ZeusCameraPos", (getPosASL curatorCamera), [2,clientOwner,_HCNetworkID]];
  player setVariable ["A3PE_IsConnectedUav", UAVControl (getConnectedUAV player), [2,clientOwner,_HCNetworkID]];
  player setVariable ["A3PE_ShownUAVFeed", shownUAVFeed, [2,clientOwner,_HCNetworkID]];
  player setVariable ["A3PE_ForceRenderDistance", ForceRenderDistance, [2,clientOwner,_HCNetworkID]];
  player setVariable ["A3PE_HigherQualityAI", HigherQualityAI, [2,clientOwner,_HCNetworkID]];
  player setVariable ["A3PE_HigherQualityDead", HigherQualityDead, [2,clientOwner,_HCNetworkID]];
  player setVariable ["A3PE_HigherQualityPlayer", HigherQualityPlayer, [2,clientOwner,_HCNetworkID]];
  player setVariable ["A3PE_EnablePlayerHide", EnablePlayerHide, [2,clientOwner,_HCNetworkID]];
  player setVariable ["A3PE_EnableVehicleHide", EnableVehicleHide, [2,clientOwner,_HCNetworkID]];
  player setVariable ["A3PE_EnableDeadHide", EnableDeadHide, [2,clientOwner,_HCNetworkID]];
  player setVariable ["A3PE_EnableAIHide", EnableDeadHide, [2,clientOwner,_HCNetworkID]];
};

if (EnableHCOverride && {!hasInterface && {!isDedicated && {!(missionNamespace getVariable ["A3PE_HCOverride", false])}}}) then {
  missionNamespace setVariable ["A3PE_HCOverride", true, true];
  missionNamespace setVariable ["A3PE_HCNetworkID", clientOwner, true];
  [] spawn {
    while {true} do {
      _allUnits = allUnits;
      _allDeadMen = allDeadMen;
      _allPlayers = allPlayers;
      _vehicles = vehicles;
      {
        _PlayerEnabled = _x getVariable ["A3PE_Enabled", false];
        if (_PlayerEnabled == true) then {
          [_x,_allUnits,_allDeadMen,_allPlayers,_vehicles] call A3PE_fnc_hideServer;
        };
      } forEach allPlayers;
    }; // While Loop
  }; // Spawn
}; //Is Headless Client


if (isServer) then {
  [] spawn {
    while {!(missionNamespace getVariable ["A3PE_HCOverride", false])} do {
      _allUnits = allUnits;
      _allDeadMen = allDeadMen;
      _allPlayers = allPlayers;
      _vehicles = vehicles;
      {
        _PlayerEnabled = _x getVariable ["A3PE_Enabled", false];
        if (_PlayerEnabled == true) then {
          [_x,_allUnits,_allDeadMen,_allPlayers,_vehicles] call A3PE_fnc_hideServer;
        };
      } forEach allPlayers;
    }; // While Loop
  }; // Spawn
}; // isServer
