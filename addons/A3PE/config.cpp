class CfgPatches {
	class A3PE {
		weapons[]={};
		requiredAddons[]={"cba_main"};
		author="Battlekeeper";
		authorUrl="";
		units[]={};
		class MyMod_main {
				version = 1.8;
				versionStr = "1.8.1";
				versionAr[] = {1, 8, 1};
    	};
	};
};
class CfgFunctions {
	class A3PE_functions_f {
		tag="A3PE";
		class Misc {
			file="\A3PE\Functions";
			class toggle {};
			class hideClient {};
			class hideServer {};
		};
	};
};
class Extended_PostInit_EventHandlers {
	class A3PEInit_functions_f {
		init="nul = [] execVM 'A3PE\functions\A3PEInit.sqf'";
	};
};
