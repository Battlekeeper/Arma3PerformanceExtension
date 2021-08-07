params ["_allObjsHide","_allObjsShow"];

{
if !(isObjectHidden _x) then {
  _x hideObject true;
};
} forEach _allObjsHide;

{
if (isObjectHidden _x) then {
  _x hideObject false;
};
} forEach _allObjsShow;
