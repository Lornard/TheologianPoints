-- Great Theologian_Policies
-- Author: lorna
-- DateCreated: 9/24/2019 9:21:40 PM
--------------------------------------------------------------

INSERT INTO Types
		(Type,								Kind)
VALUES	('POLICY_MYTHICAL_STUDIES',			'KIND_POLICY'),
		('POLICY_MINISTERIAL_TRAINING',		'KIND_POLICY');

INSERT INTO Policies 
		(PolicyType,					Description,									PrereqCivic,				Name,										GovernmentSlotType	)
VALUES	('POLICY_MYTHICAL_STUDIES',		'LOC_POLICY_MYTHICAL_STUDIES_DESCRIPTION',		'CIVIC_THEOLOGY',			'LOC_POLICY_MYTHICAL_STUDIES_NAME',			'SLOT_GREAT_PERSON'	),
		('POLICY_MINISTERIAL_TRAINING',	'LOC_POLICY_MINISTERIAL_TRAINING_DESCRIPTION',	'CIVIC_REFORMED_CHURCH',	'LOC_MINISTERIAL_TRAINING_STUDIES_NAME',	'SLOT_GREAT_PERSON'	);

INSERT INTO ObsoletePolicies 
		(PolicyType,					ObsoletePolicy,				RequiresAvailableGreatPersonClass	)
VALUES	('POLICY_MYTHICAL_STUDIES',		'POLICY_MYTHICAL_STUDIES',	'GREAT_PERSON_CLASS_JFD_THEOLOGIAN'	),
		('POLICY_MINISTERIAL_TRAINING',	NULL,						'GREAT_PERSON_CLASS_JFD_THEOLOGIAN'	);

INSERT INTO Modifiers
		(ModifierId,						ModifierType,							SubjectRequirementSetId)
VALUES	('MYTHICAL_THEOLOGIAN',				'MODIFIER_PLAYER_ADJUST_PERSON_POINTS',	NULL						),
		('MINISTERIAL_THEOLOGIAN_TEMPLE',	'MODIFIER_PLAYER_ADJUST_PERSON_POINTS',	'GTP_BUILDING_IS_TEMPLE'	),
		('MINISTERIAL_THEOLOGIAN_WORSHIP',	'MODIFIER_PLAYER_ADJUST_PERSON_POINTS',	'GTP_BUILDING_IS_WORSHIP'	);

INSERT INTO ModifierArguments
		(ModifierId,						Name,					Type, 				Value								)
VALUES	('MYTHICAL_THEOLOGIAN',				'GreatPersonClassType',	'ARGTYPE_IDENTITY',	'PERSON_CLASS_JFD_THEOLOGIAN'		),
		('MYTHICAL_THEOLOGIAN',				'Amount',				'ARGTYPE_IDENTITY', 2									),
		('MINISTERIAL_THEOLOGIAN_TEMPLE',	'GreatPersonClassType',	'ARGTYPE_IDENTITY',	'PERSON_CLASS_JFD_THEOLOGIAN'		),
		('MINISTERIAL_THEOLOGIAN_TEMPLE',	'Amount',				'ARGTYPE_IDENTITY', 2									),
		('MINISTERIAL_THEOLOGIAN_WORSHIP',	'GreatPersonClassType',	'ARGTYPE_IDENTITY',	'PERSON_CLASS_JFD_THEOLOGIAN'		),
		('MINISTERIAL_THEOLOGIAN_WORSHIP',	'Amount',				'ARGTYPE_IDENTITY', 4									);

INSERT INTO PolicyModifiers
		(PolicyType,					ModifierId)
VALUES	('POLICY_MYTHICAL_STUDIES',		'MYTHICAL_GREAT_THEOLOGIAN'),
		('POLICY_MINISTERIAL_TRAINING', 'MINISTERIAL_THEOLOGIAN_TEMPLE'),
		('POLICY_MINISTERIAL_TRAINING', 'MINISTERIAL_THEOLOGIAN_WORSHIP');
