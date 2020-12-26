-- GreatTheologiansPoints
-- Author: lorna
-- Let's try creating a THEOLOGIAN GPP
-- DateCreated: 7/19/2019 7:51:20 PM
--------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------
--	Creating the Specific Great Person Points Theologian Pseudoyields
-- Types, PseudoYields
----------------------------------------------------------------------------------------------------------------------------
INSERT INTO Types
		(Type,													Kind							)
VALUES	('PSEUDOYIELD_GPP_THEOLOGIAN',							'KIND_PSEUDOYIELD'				);

INSERT INTO PseudoYields
		(PseudoYieldType,				DefaultValue	)
VALUES	('PSEUDOYIELD_GPP_THEOLOGIAN',	0.5				);


----------------------------------------------------------------------------------------------------------------------------
--	Altering the PseudoYields from the Theologian from Great Prophet to the specific type just created.
-- GreatPersonClasses
----------------------------------------------------------------------------------------------------------------------------
UPDATE GreatPersonClasses 
	SET PseudoYieldType = 'PSEUDOYIELD_GPP_THEOLOGIAN'
	WHERE GreatPersonClassType = 'GREAT_PERSON_CLASS_JFD_THEOLOGIAN';


----------------------------------------------------------------------------------------------------------------------------
--	Altering how much the AI will chase the theologian points. 
--  As Great Prophet Points will not be used again beyond one per civ, re-add the -100 at renaissence.
--  Also, reactivate the faith per unused Great Person.
-- AiFavoredItems, GlobalParameters
----------------------------------------------------------------------------------------------------------------------------
INSERT OR REPLACE INTO AiFavoredItems
		(ListType,							Item,							Value,	StringVal,		TooltipString								)
VALUES	('GreatPersonObsessedGreatPeople',	'PSEUDOYIELD_GPP_THEOLOGIAN',	50,		NULL,			NULL										),
		('ClassicalPseudoYields',			'PSEUDOYIELD_GPP_THEOLOGIAN',	20,		NULL,			NULL										),
		('MedievalPseudoYields',			'PSEUDOYIELD_GPP_THEOLOGIAN',	40,		NULL,			NULL										),
		('RenaissancePseudoYields',			'PSEUDOYIELD_GPP_THEOLOGIAN',	20,		NULL,			NULL										),
		('RenaissancePseudoYields',			'PSEUDOYIELD_GPP_PROPHET',		-100,	NULL,			NULL										);

UPDATE GlobalParameters
SET Value = 1
WHERE Name = 'FAITH_PER_UNUSED_GREAT_PERSON_POINT';


----------------------------------------------------------------------------------------------------------------------------
--	Adding Great Theologian Pointss(GTP) in the the buildings of the Holy Site, as it's a separete yield now.
--	Also, adds some points to the Madrasa (Arabia's UI), as thematically fits as Religion Scholars.
-- District_GreatPersonPoints, Building_GreatPersonPoints
-- Update: Moved the GTP from the Holy Site to a second point in the worship building.
----------------------------------------------------------------------------------------------------------------------------

--- Temples and Madrasa
INSERT OR IGNORE INTO Building_GreatPersonPoints
		(BuildingType,					GreatPersonClassType,					PointsPerTurn	)
VALUES	('BUILDING_TEMPLE',				'GREAT_PERSON_CLASS_JFD_THEOLOGIAN',	1				),
	-- Also adding some Theologian Points to the Madrasa
		('BUILDING_MADRASA',			'GREAT_PERSON_CLASS_JFD_THEOLOGIAN',	1				);

-- Unique Temples
INSERT OR IGNORE INTO Building_GreatPersonPoints
			(BuildingType,			GreatPersonClassType,					PointsPerTurn	)
	SELECT	CivUniqueBuildingType,	'GREAT_PERSON_CLASS_JFD_THEOLOGIAN', 1 
		FROM BuildingReplaces WHERE ReplacesBuildingType = 'BUILDING_TEMPLE';

-- Worship Buildings
INSERT OR IGNORE INTO Building_GreatPersonPoints
			(BuildingType,		GreatPersonClassType,					PointsPerTurn	)
	SELECT	BuildingType,		'GREAT_PERSON_CLASS_JFD_THEOLOGIAN',	2
	FROM Buildings
	WHERE EnabledByReligion = 1;


----------------------------------------------------------------------------------------------------------------------------
--  Creating a trigger to add Theologian Points for modded buildings, including worship buildings
--  The Inner select tracks down if that Modifier ID is one from a worship building belief. 
--  If it is, adds the GT point to the building with the value of the Modifier (which should contain its name).
-- Building_GreatPersonPoints
-- Update: Moved the GTP from the Holy Site to a second point in the worship building.
----------------------------------------------------------------------------------------------------------------------------

CREATE TRIGGER IF NOT EXISTS t_Theologian_Temple
AFTER INSERT ON BuildingReplaces WHEN New.ReplacesBuildingType = 'BUILDING_TEMPLE'
BEGIN

	INSERT INTO Building_GreatPersonPoints
			(BuildingType,					GreatPersonClassType,					PointsPerTurn)
	VALUES	(New.CivUniqueBuildingType,		'GREAT_PERSON_CLASS_JFD_THEOLOGIAN',	1);

END;

CREATE TRIGGER IF NOT EXISTS t_Theologians_WorshipBuilding
AFTER INSERT ON Buildings WHEN New.EnabledByReligion = 1
BEGIN

	INSERT INTO Building_GreatPersonPoints
			(BuildingType,		GreatPersonClassType,					PointsPerTurn	)
	VALUES	(New.BuildingType,	'GREAT_PERSON_CLASS_JFD_THEOLOGIAN',	2				);

END;

