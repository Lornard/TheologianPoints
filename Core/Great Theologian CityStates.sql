-- Great Theologian_Changes
-- Author: lorna
-- City States - Stockholm and Bologna.
-- DateCreated: 8/10/2019 11:48:31 PM
--------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------
--	Stockholm/Bologna bonuses applies to Theologians as well, but on temples instead of Shrines.
-- Modifiers, ModifierArguments
----------------------------------------------------------------------------------------------------------------------------
INSERT INTO Modifiers 
		(ModifierId,															ModifierType,											SubjectRequirementSetId		)
VALUES	('MINOR_CIV_STOCKHOLM_UNIQUE_INFLUENCE_GREAT_THEOLOGIAN_POINTS_BONUS',	'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER',					'PLAYER_IS_SUZERAIN'		),
		('MINOR_CIV_STOCKHOLM_GREAT_THEOLOGIAN_POINTS_BONUS',					'MODIFIER_PLAYER_CITIES_ADJUST_GREAT_PERSON_POINT',		'GTP_BUILDING_IS_TEMPLE'	),
		('MINOR_CIV_BOLOGNA_UNIQUE_INFLUENCE_GREAT_THEOLOGIAN_POINTS_BONUS',	'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER',					'PLAYER_IS_SUZERAIN'		),
		('MINOR_CIV_BOLOGNA_GREAT_THEOLOGIAN_POINTS_BONUS',						'MODIFIER_PLAYER_CITIES_ADJUST_GREAT_PERSON_POINT',		'GTP_BUILDING_IS_TEMPLE'	);

INSERT INTO ModifierArguments
		(ModifierId,															Name,					Type,					Value												)
VALUES	('MINOR_CIV_STOCKHOLM_UNIQUE_INFLUENCE_GREAT_THEOLOGIAN_POINTS_BONUS',	'ModifierId',			'ARGTYPE_IDENTITY',		'MINOR_CIV_STOCKHOLM_GREAT_THEOLOGIAN_POINTS_BONUS'	),
		('MINOR_CIV_STOCKHOLM_GREAT_THEOLOGIAN_POINTS_BONUS',					'GreatPersonClassType', 'ARGTYPE_IDENTITY',		'GREAT_PERSON_CLASS_JFD_THEOLOGIAN'					),
		('MINOR_CIV_STOCKHOLM_GREAT_THEOLOGIAN_POINTS_BONUS',					'Amount',				'ARGTYPE_IDENTITY',		'1'													),
		('MINOR_CIV_BOLOGNA_UNIQUE_INFLUENCE_GREAT_THEOLOGIAN_POINTS_BONUS',	'ModifierId',			'ARGTYPE_IDENTITY',		'MINOR_CIV_BOLOGNA_GREAT_THEOLOGIAN_POINTS_BONUS'	),
		('MINOR_CIV_BOLOGNA_GREAT_THEOLOGIAN_POINTS_BONUS',						'GreatPersonClassType', 'ARGTYPE_IDENTITY',		'GREAT_PERSON_CLASS_JFD_THEOLOGIAN'					),
		('MINOR_CIV_BOLOGNA_GREAT_THEOLOGIAN_POINTS_BONUS',						'Amount',				'ARGTYPE_IDENTITY',		'1'													);