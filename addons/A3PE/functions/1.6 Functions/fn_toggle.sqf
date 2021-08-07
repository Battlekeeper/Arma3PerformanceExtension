_version = 1.6;

if ((missionNamespace getVariable ("A3PE"+(str (getPlayerUID player))) select 0)) then {


missionNamespace setVariable [("A3PE"+(str (getPlayerUID player))), [false,viewDistance,getPosASL curatorCamera,UAVControl (getConnectedUAV player),shownUAVFeed,(ForceRenderDistance),(_version),false,(HideWeapons),(ForceRenderDistancZeus)],true];
systemChat "Performance Toggled Off";


} else {
  systemChat "Performance Toggled On";
  missionNamespace setVariable [("A3PE"+(str (getPlayerUID player))), [true,viewDistance,getPosASL curatorCamera,UAVControl (getConnectedUAV player),shownUAVFeed,(ForceRenderDistance),(_version),false,(HideWeapons),(ForceRenderDistancZeus)],true];
  [_version] spawn {
    params ["_version"];
  while {(missionNamespace getVariable [("A3PE"+(str (getPlayerUID player))), false]) select 0} do {
    sleep 0.5;
    _var = (missionNamespace getVariable [("A3PE"+(str (getPlayerUID player))), false]) select 0;
    missionNamespace setVariable [("A3PE"+(str (getPlayerUID player))), [_var,viewDistance,getPosASL curatorCamera,UAVControl (getConnectedUAV player),shownUAVFeed,(ForceRenderDistance),(_version),false,(HideWeapons),(ForceRenderDistancZeus)],true];
  };
};
};
