-- Great Theologian Points - UD
-- Author: Gabriel2
-- DateCreated: 12/25/2020 3:56:36 PM
--------------------------------------------------------------

-- Mirror the Temple Points to the Monastery.
INSERT OR IGNORE INTO Building_GreatPersonPoints
		(BuildingType,					GreatPersonClassType,					PointsPerTurn	)
VALUES	('BUILDING_JNR_MONASTERY',		'GREAT_PERSON_CLASS_JFD_THEOLOGIAN',	1				),
	-- Also adding a single point to Hospitium/Garden
		('BUILDING_JNR_HOSPITIUM',		'GREAT_PERSON_CLASS_JFD_THEOLOGIAN',	1				),
		('BUILDING_JNR_GARDEN',			'GREAT_PERSON_CLASS_JFD_THEOLOGIAN',	1				);

-- Unique Monasteries (I don't know if JNR changes to the Wooden Church are being applied before or after, so i use replace here AND create a trigger).
INSERT OR IGNORE INTO Building_GreatPersonPoints
			(BuildingType,			GreatPersonClassType,					PointsPerTurn	)
	SELECT	CivUniqueBuildingType,	'GREAT_PERSON_CLASS_JFD_THEOLOGIAN',	1 
		FROM BuildingReplaces 
		WHERE ReplacesBuildingType = 'BUILDING_JNR_MONASTERY';

CREATE TRIGGER IF NOT EXISTS t_Theologian_Monastery
AFTER INSERT ON BuildingReplaces WHEN New.ReplacesBuildingType = 'BUILDING_JNR_MONASTERY'
BEGIN

	INSERT INTO Building_GreatPersonPoints
			(BuildingType,					GreatPersonClassType,					PointsPerTurn)
	VALUES	(New.CivUniqueBuildingType,		'GREAT_PERSON_CLASS_JFD_THEOLOGIAN',	1);

END;

-- Changes all references from building temple to the tier 2. (up to now, it includes stockholm/bologna suzerain bonus and the ministerial policy.)
UPDATE Modifiers 
	SET SubjectRequirementSetId = 'BUILDING_IS_HOLY_SITE_TIER2_JNR'
	WHERE SubjectRequirementSetId = 'GTP_BUILDING_IS_TEMPLE';

-- Change the policy card to affect tier 3 (worship) and tier 4 buildings
UPDATE Modifiers 
	SET SubjectRequirementSetId = 'BUILDING_IS_HOLY_SITE_TIER3_JNR'
	WHERE ModifierId = 'MINISTERIAL_THEOLOGIAN_TEMPLE';

UPDATE Modifiers 
	SET SubjectRequirementSetId = 'BUILDING_IS_HOLY_SITE_TIER4_JNR'
	WHERE ModifierId = 'MINISTERIAL_THEOLOGIAN_WORSHIP';
