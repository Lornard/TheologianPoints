-- Great Theologian Changes
-- Author: Gabriel2
-- DateCreated: 12/25/2020 3:43:30 PM
--------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------
--  Changing Boromeu to give a permanent +5 Combat Bonus instead of permanent Debater.
----------------------------------------------------------------------------------------------------------------------------
DELETE FROM GreatPersonIndividualActionModifiers 
WHERE	GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_JFD_CHARLES_BORROMEO';

DELETE FROM ModifierArguments
WHERE	ModifierId LIKE 'GREATPERSON_JFD_CHARLES_BORROMEO_%';

DELETE FROM Modifiers
WHERE	ModifierId LIKE 'GREATPERSON_JFD_CHARLES_BORROMEO_%';

INSERT INTO Types 
		(Type,								Kind)
VALUES	('ABILITY_COMBAT_BONUS_BORROMEO',	'KIND_ABILITY');

INSERT INTO TypeTags
		(Type,								Tag)
VALUES	('ABILITY_COMBAT_BONUS_BORROMEO',	'CLASS_RELIGIOUS_ALL');

INSERT OR IGNORE INTO UnitAbilities
		('UnitAbilityType',					'Name',										'Description',										'Inactive',	'ShowFloatTextWhenEarned',	'Permanent')
VALUES	('ABILITY_COMBAT_BONUS_BORROMEO',	'LOC_ABILITY_COMBAT_BONUS_BORROMEO_NAME',	'LOC_ABILITY_COMBAT_BONUS_BORROMEO_DESCRIPTION',	1,			0,							1);

INSERT OR IGNORE INTO UnitAbilityModifiers
		('UnitAbilityType',					'ModifierId')
VALUES	('ABILITY_COMBAT_BONUS_BORROMEO',	'GT_COMBAT_BONUS_BORROMEO');

INSERT OR IGNORE INTO Modifiers			
		(ModifierId,									ModifierType,								RunOnce,	Permanent,	SubjectRequirementSetId)
VALUES	('GREATPERSON_JFD_CHARLES_BORROMEO_COMBAT',		'MODIFIER_PLAYER_UNITS_GRANT_ABILITY',		0,			1,			null),
		('GT_COMBAT_BONUS_BORROMEO',					'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH',		0,			0,			null);

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,									Name,			Type,					Value)
VALUES	('GREATPERSON_JFD_CHARLES_BORROMEO_COMBAT',		'AbilityType',	'ARGTYPE_IDENTITY',		'ABILITY_COMBAT_BONUS_BORROMEO'),
		('GT_COMBAT_BONUS_BORROMEO',					'Amount',		'ARGTYPE_IDENTITY',		5);

INSERT OR IGNORE INTO ModifierStrings
		(ModifierId,					Context,	Text)
VALUES	('GT_COMBAT_BONUS_BORROMEO',	'Preview',	'LOC_MODIFIER_COMBAT_BONUS_BORROMEO_DESCRIPTION');

INSERT INTO GreatPersonIndividualActionModifiers
		(GreatPersonIndividualType,							ModifierId,									AttachmentTargetType)
VALUES	('GREAT_PERSON_INDIVIDUAL_JFD_CHARLES_BORROMEO',	'GREATPERSON_JFD_CHARLES_BORROMEO_COMBAT',	'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_PLAYER');
					
----------------------------------------------------------------------------------------------------------------------------
--  Xiong Shili: Creates a validation if JFD's Cultural Policy Slots exists. If it doesn't, it'll give a Governor promotion instead.
----------------------------------------------------------------------------------------------------------------------------
DELETE FROM ModifierArguments
WHERE	ModifierId = 'GREATPERSON_JFD_XIONG_SHILI_CULTURAL_SLOT'
		AND NOT EXISTS (SELECT 1 FROM GovernmentSlots WHERE GovernmentSlotType = 'SLOT_JFD_CULTURAL');

DELETE FROM Modifiers
WHERE	ModifierId = 'GREATPERSON_JFD_XIONG_SHILI_CULTURAL_SLOT'
		AND NOT EXISTS (SELECT 1 FROM GovernmentSlots WHERE GovernmentSlotType = 'SLOT_JFD_CULTURAL');

DELETE FROM GreatPersonIndividualActionModifiers
WHERE	GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_JFD_XIONG_SHILI'
		AND NOT EXISTS (SELECT 1 FROM GovernmentSlots WHERE GovernmentSlotType = 'SLOT_JFD_CULTURAL');

INSERT OR IGNORE INTO GreatPersonIndividualActionModifiers
			(GreatPersonIndividualType, 					ModifierId, 								AttachmentTargetType)
	SELECT DISTINCT	
			'GREAT_PERSON_INDIVIDUAL_JFD_XIONG_SHILI',	    'GREATPERSON_GOVERNOR_POINTS',				'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE'
	FROM GovernmentSlots WHERE NOT EXISTS (SELECT 1 FROM GovernmentSlots WHERE GovernmentSlotType = 'SLOT_JFD_CULTURAL');
	
INSERT OR IGNORE INTO GreatPersonIndividualActionModifiers
		(GreatPersonIndividualType, 					ModifierId, 						AttachmentTargetType)
VALUES	('GREAT_PERSON_INDIVIDUAL_JFD_XIONG_SHILI',		'GREATPERSON_ATOMICCIVICBOOST',		'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE');

UPDATE	GreatPersonIndividuals
SET		ActionEffectTextOverride='LOC_GREAT_PERSON_JFD_XIONG_SHILI_ALT_HELP'
WHERE	GreatPersonIndividualType='GREAT_PERSON_INDIVIDUAL_JFD_XIONG_SHILI' AND NOT EXISTS (SELECT 1 FROM GovernmentSlots WHERE GovernmentSlotType = 'SLOT_JFD_CULTURAL');

INSERT OR IGNORE INTO Modifiers			
		(ModifierId,											ModifierType,												RunOnce,	Permanent,	SubjectRequirementSetId)
VALUES	
		('GREATPERSON_ATOMICCIVICBOOST',						'MODIFIER_PLAYER_GRANT_RANDOM_CIVIC_BOOST_BY_ERA',			1,			1,			null);

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,													Name,						Type,					Value)
VALUES	('GREATPERSON_ATOMICCIVICBOOST',						'StartEraType',						'ARGTYPE_IDENTITY',		'ERA_ATOMIC'),
		('GREATPERSON_ATOMICCIVICBOOST',						'EndEraType',						'ARGTYPE_IDENTITY',		'ERA_ATOMIC'),
		('GREATPERSON_ATOMICCIVICBOOST',						'Amount',							'ARGTYPE_IDENTITY',		'1');
