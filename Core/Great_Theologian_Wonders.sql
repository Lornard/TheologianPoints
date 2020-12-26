-- Great Theologian_Wonders
-- Author: lorna
-- DateCreated: 9/22/2019 9:11:51 PM
--------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------
--	Adding Theologian Points for World Wonders and Theologian support for the Oracle.
-- Modifiers, ModifierArguments, BuildingModifiers, Building_GreatPersonPoints
----------------------------------------------------------------------------------------------------------------------------
-- Oracle
INSERT INTO Modifiers 
		(ModifierId,						ModifierType,													SubjectRequirementSetId	)
VALUES	('ORACLE_GREATTHEOLOGIANPOINTS',	'MODIFIER_SINGLE_CITY_DISTRICTS_ADJUST_GREAT_PERSON_POINTS',    'DISTRICT_IS_HOLY_SITE'	);

INSERT INTO ModifierArguments
		(ModifierId,						Name,					Type,					Value								)
VALUES	('ORACLE_GREATTHEOLOGIANPOINTS',	'Amount',				'ARGTYPE_IDENTITY',		2									),
		('ORACLE_GREATTHEOLOGIANPOINTS',	'GreatPersonClassType', 'ARGTYPE_IDENTITY',		'GREAT_PERSON_CLASS_JFD_THEOLOGIAN');

INSERT INTO BuildingModifiers
			(BuildingType,	ModifierId						)
	SELECT	BuildingType,	'ORACLE_GREATTHEOLOGIANPOINTS'	
	FROM Buildings WHERE BuildingType = 'BUILDING_ORACLE';

-- Other Wonders
INSERT INTO Building_GreatPersonPoints
			(BuildingType,	GreatPersonClassType,					PointsPerTurn	)
	SELECT	BuildingType,	'GREAT_PERSON_CLASS_JFD_THEOLOGIAN',	1				
	FROM Buildings WHERE BuildingType IN 
	(
		'BUILDING_ANGKOR_WAT', 
		'BUILDING_ST_BASILS_CATHEDRAL',
		'BUILDING_BAMYAN'						--Community Wonder Mod
	);

INSERT INTO Building_GreatPersonPoints
			(BuildingType,	GreatPersonClassType,					PointsPerTurn	)
	SELECT	BuildingType,	'GREAT_PERSON_CLASS_JFD_THEOLOGIAN',	2				
	FROM Buildings WHERE BuildingType IN 
	(
		'BUILDING_STONEHENGE',
		'BUILDING_HAGIA_SOPHIA',
		'BUILDING_KOTOKU_IN',
		'BUILDING_MAHABODHI_TEMPLE',
		'BUILDING_MONT_ST_MICHEL',
		'BUILDING_MEENAKSHI_TEMPLE', 
		'BUILDING_UNIVERSITY_SANKORE',
		'BUILDING_BOROBUDUR',					--Community Wonder Mod
		'BUILDING_ITSUKUSHIMA'					--Community Wonder Mod
	);

-- As i'm not sure which load order the Wonder Mods will take, use triggers if they load after this
CREATE TRIGGER IF NOT EXISTS t_Theologians_Wonders
AFTER INSERT ON Buildings WHEN New.BuildingType IN	
	(
		'BUILDING_BAMYAN'
	)
BEGIN

	INSERT INTO Building_GreatPersonPoints
			(BuildingType,		GreatPersonClassType,					PointsPerTurn	)
	VALUES	(New.BuildingType,	'GREAT_PERSON_CLASS_JFD_THEOLOGIAN',	1				);

END;

CREATE TRIGGER IF NOT EXISTS t_Theologians_Wonders
AFTER INSERT ON Buildings WHEN New.BuildingType IN	
	(
		'BUILDING_ITSUKUSHIMA'
	)
BEGIN

	INSERT INTO Building_GreatPersonPoints
			(BuildingType,		GreatPersonClassType,					PointsPerTurn	)
	VALUES	(New.BuildingType,	'GREAT_PERSON_CLASS_JFD_THEOLOGIAN',	2				);

END;

CREATE TRIGGER IF NOT EXISTS t_Theologians_Wonders
AFTER INSERT ON Buildings WHEN New.BuildingType IN	
	(
		'BUILDING_BOROBUDUR'
	)
BEGIN

	INSERT INTO Building_GreatPersonPoints
			(BuildingType,		GreatPersonClassType,					PointsPerTurn	)
	VALUES	(New.BuildingType,	'GREAT_PERSON_CLASS_JFD_THEOLOGIAN',	2				);

END;