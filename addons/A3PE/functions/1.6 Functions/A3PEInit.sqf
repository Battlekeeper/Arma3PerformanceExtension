#include "\a3\ui_f\hpp\definedikcodes.inc"



if (!isDedicated) then {
_version = 1.6;
["Toggle Performance Enhance", "Toggle_Performance", "Toggle Performance Enhance", {_this call A3PE_fnc_toggle}, {}, [DIK_U, [false, false, false]],false,0,true] call cba_fnc_addKeybind;
["ForceRenderDistance","SLIDER",["Force Render Range in Meters","Range at which units are force rendered, units in this range will be rendered even if you cannot see them."],"Arma 3 Performance Settings",[0, 100, 10, 0],nil,{},false] call CBA_fnc_addSetting;
["ForceRenderDistancZeus","SLIDER",["Force Render Range in Meters When in Zeus","Range at which units are force rendered while in zeus, units in this range will be rendered even if you cannot see them."],"Arma 3 Performance Settings",[0, 100, 10, 0],nil,{},false] call CBA_fnc_addSetting;
["HideWeapons","CHECKBOX",["Hide Weapons On Ground","When checked the mod will hide weapons and AI."],"Arma 3 Performance Settings",true,0,{},false] call CBA_fnc_addSetting;


missionNamespace setVariable [("A3PE"+(str (getPlayerUID player))), [false,viewDistance,getPosASL curatorCamera,UAVControl (getConnectedUAV player),shownUAVFeed,(ForceRenderDistance),_version,false,(HideWeapons),(ForceRenderDistancZeus)], true];
};


if (isServer) then {
[] spawn {
_ServerVersion = 1.6;
_WrongVersionArray = [];

while {true} do {
sleep .02;
{
_HasWrongVersion = (missionNamespace getVariable [("A3PE"+(str (getPlayerUID _x))), 1]) select 7;
_PlayerVersion = (missionNamespace getVariable [("A3PE"+(str (getPlayerUID _x))), 1]) select 6;
if !(_x in _WrongVersionArray) then {
if (_HasWrongVersion) then {
_WrongVersionArray pushBack _x;
_error = "ERROR: Your Arma 3 Performance Mod Version is not the same as the servers:\nYour Version: " + str _PlayerVersion + "\nServer Version: " + str _ServerVersion;
_error remoteExecCall ["hint", _x];
};
};
if !(_x in _WrongVersionArray) then {
[_x] call A3PE_fnc_hide;
};
} forEach allPlayers;
};
};
};
