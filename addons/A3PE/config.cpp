class CfgPatches
{
	class PiR
	{
		weapons[]={};
		requiredVersion=2.02;
		requiredAddons[]={};
		author="Battlekeeper";
		authorUrl="";
		units[]={};
	};
};
class CfgFunctions
{
	class A3PE_functions_f
	{
		tag="A3PE";
		class Misc
		{
			file="\A3PE\Functions";
			class toggle
			{
			};
			class loop
			{
			};
			class hide
			{
			};
		};
	};
};
class Extended_PostInit_EventHandlers
{
	class A3PEInit_functions_f
	{
		init="nul = [] execVM 'A3PE\functions\A3PEInit.sqf'";
	};
};
class cfgMods
{
	author="Battlekeeper";
	timepacked="1628082446";
};
