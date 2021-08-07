params ["_player"];
_ServerVersion = 1.6;
_PlayerVersion = (missionNamespace getVariable [("A3PE"+(str (getPlayerUID _player))), 1]) select 6;
_onoff = (missionNamespace getVariable [("A3PE"+(str (getPlayerUID _player))), false]) select 0;
_ViewDistance = (missionNamespace getVariable [("A3PE"+(str (getPlayerUID _player))), false]) select 1;
_ZeusCam = (missionNamespace getVariable [("A3PE"+(str (getPlayerUID _player))), false]) select 2;
_IsInUAV = (missionNamespace getVariable [("A3PE"+(str (getPlayerUID _player))), false]) select 3;
_ShownUAV = (missionNamespace getVariable [("A3PE"+(str (getPlayerUID _player))), false]) select 4;
_UAV = getConnectedUAV _player;
_ForceRenderDistance = (missionNamespace getVariable [("A3PE"+(str (getPlayerUID _player))), false]) select 5;
_HideWeapons = (missionNamespace getVariable [("A3PE"+(str (getPlayerUID _player))), true]) select 8;
_ForceRenderDistanceZeus = (missionNamespace getVariable [("A3PE"+(str (getPlayerUID _player))), false]) select 9;

if (_PlayerVersion == _ServerVersion) then {
if (_onoff) then {

_allObjsHide = [];
_allObjsShow = [];
_allunits = allUnits;
_allunits1 = [_allunits, ((count _allunits) / 2)] call BIS_fnc_subSelect;
_allunits deleteRange [((count _allunits) / 2),count _allunits];
_allunits2 = _allunits;



_allunits3 = [_allunits1, ((count _allunits1) / 2)] call BIS_fnc_subSelect;
_allunits1 deleteRange [((count _allunits1) / 2),count _allunits1];

_allunits4 = [_allunits2, ((count _allunits2) / 2)] call BIS_fnc_subSelect;
_allunits2 deleteRange [((count _allunits2) / 2),count _allunits2];


[_allunits1,_player] call A3PE_fnc_loop;
[_allunits2,_player] call A3PE_fnc_loop;
[_allunits3,_player] call A3PE_fnc_loop;
[_allunits4,_player] call A3PE_fnc_loop;

_alldeadmen = allDeadMen;
_alldeadmen1 = [_alldeadmen, ((count _alldeadmen) / 2)] call BIS_fnc_subSelect;
_alldeadmen deleteRange [((count _alldeadmen) / 2),count _alldeadmen];
_alldeadmen2 = _alldeadmen;

[_alldeadmen1,_player] call A3PE_fnc_loop;
[_alldeadmen2,_player] call A3PE_fnc_loop;

if (_HideWeapons) then {
{
if (_ViewDistance > _player distance2D _x) then {
if (_player distance2D _x > _ForceRenderDistance) then {
_obj = _x;
_vis = 0;
_arr = lineIntersectsWith [AGLToASL (position _obj), AGLToASL (_obj modelToWorld [0,0,0]), _obj, objNull, true];

if (isNull objectParent _player) then {
_vis = [_player, "VIEW", _obj] checkVisibility [eyePos _player, AGLToASL (position _x)];
_vis = [_player, "VIEW", _obj] checkVisibility [eyePos _player, AGLToASL (_x modelToWorld [0,0,2])];
} else {
_vis = [vehicle _player, "VIEW", _obj] checkVisibility [eyePos _player, AGLToASL (_x modelToWorld [0,0,2])];
};

if (count _arr > 0) then {
if ((_arr select 0) isKindOf "Building") then {
  _allObjsShow pushBack _obj;;
} else {
if (_vis == 0) then {
  _allObjsHide pushBack _obj;
} else {
  _allObjsShow pushBack _obj;
};
};
} else {
  if (_vis == 0) then {
    _allObjsHide pushBack _obj;
  } else {
    _allObjsShow pushBack _obj;
  };
};

} else {_allObjsShow pushBack _x;};
} else {_allObjsHide pushBack _x;};
} forEach allMissionObjects "GroundWeaponHolder";


if !(_ZeusCam isEqualTo [0,0,0]) then {
{
if (_ViewDistance > (ASLToAGL _ZeusCam) distance2D _x) then {
if ((ASLToAGL _ZeusCam) distance2D _x > _ForceRenderDistanceZeus) then {
_obj = _x;
_vis = 0;
_arr = lineIntersectsWith [AGLToASL (position _obj), AGLToASL (_obj modelToWorld [0,0,0]), _obj, objNull, true];

_vis = [objNull, "VIEW", _obj] checkVisibility [_ZeusCam, AGLToASL (position _x)];
_vis = [objNull, "VIEW", _obj] checkVisibility [_ZeusCam, AGLToASL (_x modelToWorld [0,0,2])];


if (count _arr > 0) then {
if ((_arr select 0) isKindOf "Building") then {
  _allObjsHide deleteAt (_allObjsHide find _obj);
  _allObjsShow pushBackUnique _obj;
} else {
if (_vis == 0) then {
  if !(_x in _allObjsShow) then {
    _allObjsHide pushBackUnique _x;
  };
} else {
  _allObjsHide deleteAt (_allObjsHide find _obj);
  _allObjsShow pushBackUnique _obj;
};
};
} else {
  if (_vis == 0) then {
    if !(_x in _allObjsShow) then {
      _allObjsHide pushBackUnique _x;
    };
  } else {
    _allObjsHide deleteAt (_allObjsHide find _obj);
    _allObjsShow pushBackUnique _obj;
  };
};

} else {
  _allObjsHide deleteAt (_allObjsHide find _obj);
  _allObjsShow pushBackUnique _obj;
};
} else {
  if !(_x in _allObjsShow) then {
      _allObjsHide pushBackUnique _x;
    };
  };
} forEach allMissionObjects "GroundWeaponHolder";
};


if (_IsInUAV select 1 != "" || _ShownUAV) then {
{
if (_ViewDistance > _UAV distance2D _x) then {
if (_UAV distance2D _x > _ForceRenderDistance) then {
_obj = _x;
_vis = 0;
_arr = lineIntersectsWith [AGLToASL (position _obj), AGLToASL (_obj modelToWorld [0,0,0]), _obj, objNull, true];

_vis = [_UAV, "VIEW", _obj] checkVisibility [GetPosASL _UAV, AGLToASL (position _x)];
_vis = [_UAV, "VIEW", _obj] checkVisibility [GetPosASL _UAV, AGLToASL (_x modelToWorld [0,0,2])];

if (count _arr > 0) then {
if ((_arr select 0) isKindOf "Building") then {
  _allObjsHide deleteAt (_allObjsHide find _obj);
  _allObjsShow pushBackUnique _obj;
} else {
if (_vis == 0) then {
  if !(_x in _allObjsShow) then {
    _allObjsHide pushBackUnique _x;
  };
} else {
  _allObjsHide deleteAt (_allObjsHide find _obj);
  _allObjsShow pushBackUnique _obj;
};
};
} else {
  if (_vis == 0) then {
    if !(_x in _allObjsShow) then {
      _allObjsHide pushBackUnique _x;
    };
  } else {
    _allObjsHide deleteAt (_allObjsHide find _obj);
    _allObjsShow pushBackUnique _obj;
  };
};

} else {
_allObjsHide deleteAt (_allObjsHide find _obj);
_allObjsShow pushBackUnique _obj;};
} else {
  if !(_x in _allObjsShow) then {
    _allObjsHide pushBackUnique _x;
  };
};
} forEach allMissionObjects "GroundWeaponHolder";
};


[{_x hideObject true;}, _allObjsHide] remoteExecCall ["forEach", _player];
[{_x hideObject false;}, _allObjsShow] remoteExecCall ["forEach", _player];
};
};
} else {
_onoff = (missionNamespace getVariable [("A3PE"+(str (getPlayerUID _player))), false]) select 0;
_ViewDistance = (missionNamespace getVariable [("A3PE"+(str (getPlayerUID _player))), false]) select 1;
_ZeusCam = (missionNamespace getVariable [("A3PE"+(str (getPlayerUID _player))), false]) select 2;
_IsInUAV = (missionNamespace getVariable [("A3PE"+(str (getPlayerUID _player))), false]) select 3;
_ShownUAV = (missionNamespace getVariable [("A3PE"+(str (getPlayerUID _player))), false]) select 4;
_ForceRenderDistance = (missionNamespace getVariable [("A3PE"+(str (getPlayerUID _player))), false]) select 5;
_PlayerVersion = (missionNamespace getVariable [("A3PE"+(str (getPlayerUID _player))), 1]) select 6;

missionNamespace setVariable [("A3PE"+(str (getPlayerUID _player))), [_onoff,_ViewDistance,_ZeusCam,_IsInUAV,_ShownUAV,_ForceRenderDistance,_PlayerVersion,true], true];
};
