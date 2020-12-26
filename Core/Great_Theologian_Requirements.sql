-- Great Theologian Requirements
-- Author: Gabriel2
-- DateCreated: 12/25/2020 6:40:28 PM
--------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------
--	Creating necessary Requirements and RequirementSets.
-- RequirementSets, RequirementSetRequirements
----------------------------------------------------------------------------------------------------------------------------
INSERT INTO RequirementSets
		(RequirementSetId, 				RequirementSetType			)
VALUES	('GTP_BUILDING_IS_TEMPLE',		'REQUIREMENTSET_TEST_ALL'	),
		('GTP_BUILDING_IS_WORSHIP',		'REQUIREMENTSET_TEST_ANY'	);

INSERT INTO Requirements
		(RequirementId,							RequirementType)
SELECT	'GTP_REQUIRES_CITY_HAS_'||BuildingType,	'REQUIREMENT_CITY_HAS_BUILDING'
FROM Buildings WHERE EnabledByReligion = 1;

INSERT INTO RequirementArguments
		(RequirementId,								Name,			Value)
SELECT	'GTP_REQUIRES_CITY_HAS_' ||BuildingType,	'BuildingType',	BuildingType
FROM Buildings WHERE EnabledByReligion = 1;

INSERT INTO RequirementSetRequirements
		(RequirementSetId, 				RequirementId)
VALUES	('GTP_BUILDING_IS_TEMPLE',		'REQUIRES_CITY_HAS_TEMPLE');

INSERT INTO RequirementSetRequirements
		(RequirementSetId,							RequirementId)
SELECT	'GTP_BUILDING_IS_WORSHIP',		'GTP_REQUIRES_CITY_HAS_'||BuildingType
FROM Buildings WHERE EnabledByReligion = 1;

CREATE TRIGGER IF NOT EXISTS t_Theologians_Requirements_WorshipBuilding
AFTER INSERT ON Buildings WHEN New.EnabledByReligion = 1
BEGIN

	INSERT INTO Requirements
			(RequirementId,									RequirementType)
	VALUES	('GTP_REQUIRES_CITY_HAS_'||New.BuildingType,	'REQUIREMENT_CITY_HAS_BUILDING');

	INSERT INTO RequirementArguments
			(RequirementId,									Name,				Value)
	VALUES	('GTP_REQUIRES_CITY_HAS_'||New.BuildingType,	'BuildingType',		New.BuildingType);

	INSERT INTO RequirementSetRequirements
			(RequirementSetId,				RequirementId)
	VALUES	('GTP_BUILDING_IS_WORSHIP',		'GTP_REQUIRES_CITY_HAS_'||New.BuildingType);

END;

