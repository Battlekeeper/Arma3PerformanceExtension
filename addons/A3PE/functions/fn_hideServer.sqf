params ["_player","_allUnits","_allDeadMen","_allPlayers","_vehicles"];
_ViewDistance = _player getVariable ["A3PE_ViewDistance", 3000];
_ZeusCameraPos = _player getVariable ["A3PE_ZeusCameraPos", [0,0,0]];
_IsConnectedUav = _player getVariable ["A3PE_IsConnectedUav", [objNull, ""]];
_ShownUAVFeed = _player getVariable ["A3PE_ShownUAVFeed", false];
_ForceRenderDistance = _player getVariable ["A3PE_ForceRenderDistance", 10];
_ForceRenderDistanceZeus = _player getVariable ["A3PE_ForceRenderDistanceZeus", 10];
_HigherQualityAI = _player getVariable ["A3PE_HigherQualityAI", false];
_HigherQualityDead = _player getVariable ["A3PE_HigherQualityDead", false];
_EnablePlayerHide = _player getVariable ["A3PE_EnablePlayerHide", false];
_HigherQualityPlayer = _player getVariable ["A3PE_HigherQualityPlayer", false];
_HigherQualityVehicles = _player getVariable ["HigherQualityVehicles", false];
_EnableVehicleHide = _player getVariable ["A3PE_EnableVehicleHide", false];
_EnableDeadHide = _player getVariable ["A3PE_EnableDeadHide", true];
_EnableAIHide = _player getVariable ["A3PE_EnableAIHide", true];
_UAV = getConnectedUAV _player;
_eyePosPlayer = eyePos _player;

_allObjsHide = [];
_allObjsShow = [];
if (_EnableAIHide) then {
{
  _CheckedUnit = _x;
  _vis = 0;
  _selections = ["leftarm","rightarm","head","leftleg","rightleg"];

  if (!isPlayer _CheckedUnit) then {
    if (_ViewDistance > _player distance2D _CheckedUnit) then {
      if (_player distance2D _CheckedUnit > _ForceRenderDistance) then {
        if (isNull objectParent _CheckedUnit) then {
              {
                  _pos = _CheckedUnit selectionPosition _x;
                  _pos2 = _CheckedUnit modelToWorldWorld _pos;
                    if (isNull objectParent _player) then {
                      _visnum = [_player, "VIEW", _CheckedUnit] checkVisibility [_eyePosPlayer, _pos2];
                      _vis = _vis + _visnum;
                    } else {
                      _visnum = [(vehicle _player), "VIEW", _CheckedUnit] checkVisibility [_eyePosPlayer, _pos2];
                      _vis = _vis + _visnum;
                    };
                    if !(_ZeusCameraPos isEqualTo [0,0,0]) then {
                      _visnum = [objNull, "VIEW", _CheckedUnit] checkVisibility [_ZeusCameraPos, _pos2];
                      _vis = _vis + _visnum;
                    };
                    if (_IsConnectedUav select 1 != "" || _ShownUAVFeed) then {
                      _visnum = [_UAV, "VIEW", _CheckedUnit] checkVisibility [getPosASL _UAV, _pos2];
                      _vis = _vis + _visnum;
                    };
                    if (_HigherQualityAI) then {
                      _visnumFront = [_player, "VIEW", _CheckedUnit] checkVisibility [_player modelToWorldWorld [0,5,1], _pos2];  // front
                      _visnumLeft = [_player, "VIEW", _CheckedUnit] checkVisibility [_player modelToWorldWorld [-5,0,1], _pos2];  // left
                      _visnumRight = [_player, "VIEW", _CheckedUnit] checkVisibility [_player modelToWorldWorld [5,0,1], _pos2];  // right
                      _vis = _vis + _visnumFront + _visnumLeft + _visnumRight;
                    };
                if (_vis != 0) exitWith {_vis}; //Exit loop if unit was seen
              } forEach _selections;

              if (_vis == 0) then {
              _allObjsHide pushBack _CheckedUnit;
              } else {
              _allObjsShow pushBack _CheckedUnit;
              };
          } else {_allObjsShow pushBack _CheckedUnit;};
        } else {_allObjsShow pushBack _CheckedUnit;};
      } else {_allObjsHide pushBack _CheckedUnit;};
  }; //isPlayer
} forEach _allUnits;
};

if (_EnableDeadHide) then {
{
  _CheckedUnit = _x;
  _vis = 0;
  _selections = ["leftarm","rightarm","head","leftleg","rightleg"];

if (!isPlayer _CheckedUnit) then {
  if (_ViewDistance > _player distance2D _CheckedUnit) then {
    if (_player distance2D _CheckedUnit > _ForceRenderDistance) then {
      if (isNull objectParent _CheckedUnit) then {
          _visnum = [_player, "VIEW", _CheckedUnit] checkVisibility [_eyePosPlayer, _CheckedUnit modelToWorldWorld [0,0,0.5]];
            {
                _pos = _CheckedUnit selectionPosition _x;
                _pos2 = _CheckedUnit modelToWorldWorld _pos;
                  if (isNull objectParent _player) then {
                    _visnum = [_player, "VIEW", _CheckedUnit] checkVisibility [_eyePosPlayer, _pos2];
                    _vis = _vis + _visnum;
                  } else {
                    _visnum = [(vehicle _player), "VIEW", _CheckedUnit] checkVisibility [_eyePosPlayer, _pos2];
                    _vis = _vis + _visnum;
                  };
                  if !(_ZeusCameraPos isEqualTo [0,0,0]) then {
                    _visnum = [objNull, "VIEW", _CheckedUnit] checkVisibility [_ZeusCameraPos, _pos2];
                    _vis = _vis + _visnum;
                  };
                  if (_IsConnectedUav select 1 != "" || _ShownUAVFeed) then {
                    _visnum = [_UAV, "VIEW", _CheckedUnit] checkVisibility [getPosASL _UAV, _pos2];
                    _vis = _vis + _visnum;
                  };
                  if (_HigherQualityDead) then {
                    _visnumFront = [_player, "VIEW", _CheckedUnit] checkVisibility [_player modelToWorldWorld [0,5,1], _pos2];  // front
                    _visnumLeft = [_player, "VIEW", _CheckedUnit] checkVisibility [_player modelToWorldWorld [-5,0,1], _pos2];  // left
                    _visnumRight = [_player, "VIEW", _CheckedUnit] checkVisibility [_player modelToWorldWorld [5,0,1], _pos2];  // right
                    _vis = _vis + _visnumFront + _visnumLeft + _visnumRight;
                  };
              if (_vis != 0) exitWith {_vis}; //Exit loop if unit was seen
            } forEach _selections;

            if (_vis == 0) then {
            _allObjsHide pushBack _CheckedUnit;
            } else {
            _allObjsShow pushBack _CheckedUnit;
            };
        } else {_allObjsShow pushBack _CheckedUnit;};
      } else {_allObjsShow pushBack _CheckedUnit;};
    } else {_allObjsHide pushBack _CheckedUnit;};
  }; //isPlayer
} forEach _allDeadMen;
};


if (_EnablePlayerHide) then {
{
  _CheckedUnit = _x;
  _vis = 0;
  _selections = ["leftarm","rightarm","head","leftleg","rightleg"];

    if (_ViewDistance > _player distance2D _CheckedUnit) then {
      if (_player distance2D _CheckedUnit > _ForceRenderDistance) then {
        if (isNull objectParent _CheckedUnit) then {
              {
                  _pos = _CheckedUnit selectionPosition _x;
                  _pos2 = _CheckedUnit modelToWorldWorld _pos;
                    if (isNull objectParent _player) then {
                      _visnum = [_player, "VIEW", _CheckedUnit] checkVisibility [_eyePosPlayer, _pos2];
                      _vis = _vis + _visnum;
                    } else {
                      _visnum = [(vehicle _player), "VIEW", _CheckedUnit] checkVisibility [_eyePosPlayer, _pos2];
                      _vis = _vis + _visnum;
                    };
                    if !(_ZeusCameraPos isEqualTo [0,0,0]) then {
                      _visnum = [objNull, "VIEW", _CheckedUnit] checkVisibility [_ZeusCameraPos, _pos2];
                      _vis = _vis + _visnum;
                    };
                    if (_IsConnectedUav select 1 != "" || _ShownUAVFeed) then {
                      _visnum = [_UAV, "VIEW", _CheckedUnit] checkVisibility [getPosASL _UAV, _pos2];
                      _vis = _vis + _visnum;
                    };
                    if (_HigherQualityPlayer) then {
                      _visnumFront = [_player, "VIEW", _CheckedUnit] checkVisibility [_player modelToWorldWorld [0,5,1], _pos2];  // front
                      _visnumLeft = [_player, "VIEW", _CheckedUnit] checkVisibility [_player modelToWorldWorld [-5,0,1], _pos2];  // left
                      _visnumRight = [_player, "VIEW", _CheckedUnit] checkVisibility [_player modelToWorldWorld [5,0,1], _pos2];  // right
                      _vis = _vis + _visnumFront + _visnumLeft + _visnumRight;
                    };
                if (_vis != 0) exitWith {_vis}; //Exit loop if unit was seen
              } forEach _selections;

              if (_vis == 0) then {
              _allObjsHide pushBack _CheckedUnit;
              } else {
              _allObjsShow pushBack _CheckedUnit;
              };
          } else {_allObjsShow pushBack _CheckedUnit;};
        } else {_allObjsShow pushBack _CheckedUnit;};
      } else {_allObjsHide pushBack _CheckedUnit;};
} forEach _allPlayers;
};

if (_EnableVehicleHide) then {
{
  _CheckedUnit = _x;
  _vis = 0;
  _selections = selectionNames _CheckedUnit;

if (!isPlayer _CheckedUnit) then {
  if (_ViewDistance > _player distance2D _CheckedUnit) then {
    if (_player distance2D _CheckedUnit > _ForceRenderDistance) then {
      if (isNull objectParent _CheckedUnit) then {
          _visnum = [_player, "VIEW", _CheckedUnit] checkVisibility [_eyePosPlayer, _CheckedUnit modelToWorldWorld [0,0,0.5]];
            {
                _pos = _CheckedUnit selectionPosition _x;
                _pos2 = _CheckedUnit modelToWorldWorld _pos;
                  if (isNull objectParent _player) then {
                    _visnum = [_player, "VIEW", _CheckedUnit] checkVisibility [_eyePosPlayer, _pos2];
                    _vis = _vis + _visnum;
                  } else {
                    _visnum = [(vehicle _player), "VIEW", _CheckedUnit] checkVisibility [_eyePosPlayer, _pos2];
                    _vis = _vis + _visnum;
                  };
                  if !(_ZeusCameraPos isEqualTo [0,0,0]) then {
                    _visnum = [objNull, "VIEW", _CheckedUnit] checkVisibility [_ZeusCameraPos, _pos2];
                    _vis = _vis + _visnum;
                  };
                  if (_IsConnectedUav select 1 != "" || _ShownUAVFeed) then {
                    _visnum = [_UAV, "VIEW", _CheckedUnit] checkVisibility [getPosASL _UAV, _pos2];
                    _vis = _vis + _visnum;
                  };
                  if (_HigherQualityVehicles) then {
                    _visnumFront = [_player, "VIEW", _CheckedUnit] checkVisibility [_player modelToWorldWorld [0,5,1], _pos2];  // front
                    _visnumLeft = [_player, "VIEW", _CheckedUnit] checkVisibility [_player modelToWorldWorld [-5,0,1], _pos2];  // left
                    _visnumRight = [_player, "VIEW", _CheckedUnit] checkVisibility [_player modelToWorldWorld [5,0,1], _pos2];  // right
                    _vis = _vis + _visnumFront + _visnumLeft + _visnumRight;
                  };
              if (_vis != 0) exitWith {_vis}; //Exit loop if unit was seen
            } forEach _selections;

            if (_vis == 0) then {
            _allObjsHide pushBack _CheckedUnit;
            } else {
            _allObjsShow pushBack _CheckedUnit;
            };
        } else {_allObjsShow pushBack _CheckedUnit;};
      } else {_allObjsShow pushBack _CheckedUnit;};
    } else {_allObjsHide pushBack _CheckedUnit;};
  }; //isPlayer
} forEach _vehicles;
};

[_allObjsHide,_allObjsShow] remoteExecCall ["A3PE_fnc_hideClient", _player];
