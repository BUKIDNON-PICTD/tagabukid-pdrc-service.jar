[getPDRCMasterListByGender]
SELECT 
pdrc_detainees.`prisonno`,
pdrc_detainees.`detainee_lastname`,
pdrc_detainees.`detainee_firstname`,
pdrc_detainees.`detainee_middlename`,
xxx.`gender`,
pdrc_cases.`name` AS casefilename
FROM pdrc_detainees
INNER JOIN pdrc_detainees_details_case ON pdrc_detainees_details_case.`detaineeid` = pdrc_detainees.`objid`
INNER JOIN pdrc_cases ON pdrc_cases.`objid` = pdrc_detainees_details_case.`casefile_objid`
INNER JOIN etracs254_bukidnon.`entityindividual` xxx ON xxx.`objid` = pdrc_detainees.`objid`
WHERE pdrc_detainees_details_case.`casefile_objid`  = $P{casefileid}
${filter}
GROUP BY pdrc_detainees.`detainee_lastname` ASC

[getPDRCBukidnonNorthSouth]
SELECT pdrc_detainees.`prisonno`,
pdrc_detainees.`detainee_name`,
xxx.`gender`,
pdrc_cases.`name` AS casefilename,
pdrc_detainees_details_arrest.`dateofcommitment`,
pdrc_detainees_details_hearingdetails.`hearingdate`
FROM pdrc_detainees
INNER JOIN etracs254_bukidnon.`entityindividual` xxx ON xxx.`objid` = pdrc_detainees.`objid`
INNER JOIN pdrc_detainees_details_case ON pdrc_detainees_details_case.`detaineeid` = pdrc_detainees.`objid`
INNER JOIN pdrc_cases ON pdrc_cases.`objid` = pdrc_detainees_details_case.`casefile_objid`
INNER JOIN pdrc_detainees_details_arrest ON pdrc_detainees_details_arrest.`detaineeid` = pdrc_detainees.`objid`
INNER JOIN pdrc_detainees_details_hearingdetails ON pdrc_detainees_details_hearingdetails.`detaineeid` = pdrc_detainees.`objid`
WHERE pdrc_detainees_details_case.`casefile_objid` = $P{casefileid}
${filter}
GROUP BY pdrc_detainees.`objid`

[getPDRCCListofDetaineeWithPsychotic]
SELECT
pdrc_detainees.`prisonno`,
pdrc_detainees.`detainee_name`,
xxx.`gender`,
xxx.`civilstatus`,
pdrc_detainees_details_arrest.`hasmentalproblem`,
pdrc_detainees_details_arrest.`dateofcommitment` AS dateofdetetion,	
pdrc_cases.`name` AS casefilename , 
xxx.`birthdate`
,(PERIOD_DIFF( DATE_FORMAT(CURDATE(), '%Y%m') , DATE_FORMAT(birthdate, '%Y%m') )) DIV 12 AS ageinyears
FROM pdrc_detainees
INNER JOIN etracs254_bukidnon.`entityindividual` xxx ON xxx.`objid` = pdrc_detainees.`objid`
INNER JOIN pdrc_detainees_details_case ON pdrc_detainees_details_case.`detaineeid` = pdrc_detainees.`objid`
INNER JOIN pdrc_cases ON pdrc_cases.`objid` = pdrc_detainees_details_case.`casefile_objid`
INNER JOIN pdrc_detainees_details_arrest ON pdrc_detainees_details_arrest.`detaineeid` = pdrc_detainees.`objid`
WHERE pdrc_detainees_details_case.`casefile_objid` = $P{casefileid} AND pdrc_detainees_details_arrest.`hasmentalproblem` = TRUE
${filter}
GROUP BY pdrc_detainees.`objid`	 

[getPDRCProvinciaJail]
SELECT
pdrc_detainees.`detainee_name`,
xxx.`gender`,
xxx.`civilstatus`,
pdrc_detainees_details_arrest.`dateofcommitment` AS dateofdetention,
pdrc_cases.`name` AS casefilename,
pdrc_detainees_details_arrest.`remarks`,
xxx.`birthdate`
,(PERIOD_DIFF( DATE_FORMAT(CURDATE(), '%Y%m') , DATE_FORMAT(birthdate, '%Y%m') )) DIV 12 AS ageinyears
-- ,(PERIOD_DIFF( DATE_FORMAT(CURDATE(), '%Y%m') , DATE_FORMAT(birthdate, '%Y%m') )) MOD 12 AS months
FROM pdrc_detainees
INNER JOIN etracs254_bukidnon.`entityindividual` xxx ON xxx.`objid` = pdrc_detainees.`objid`
INNER JOIN pdrc_detainees_details_arrest ON pdrc_detainees_details_arrest.`detaineeid` = pdrc_detainees.`objid`
INNER JOIN pdrc_detainees_details_case ON pdrc_detainees_details_case.`detaineeid` = pdrc_detainees.`objid`
INNER JOIN pdrc_cases ON pdrc_cases.`objid` = pdrc_detainees_details_case.`casefile_objid`
WHERE pdrc_detainees_details_case.`casefile_objid` = $P{casefileid}
${filter}
GROUP BY pdrc_detainees.`objid`


[getPDRCDetaineesReceivedAndReceived]
SELECT 
pdrc_detainees.`prisonno`,
pdrc_detainees.`detainee_name`,
xxx.`gender`,
pdrc_cases.`name` AS casefilename,
pdrc_detainees_details_arrest.`dateofcommitment`,
pdrc_detainees_details_arrest.`datereleasedorwaive`
FROM pdrc_detainees
INNER JOIN pdrc_detainees_details_case ON pdrc_detainees_details_case.`detaineeid` = pdrc_detainees.`objid`
INNER JOIN pdrc_cases ON pdrc_cases.`objid` = pdrc_detainees_details_case.`casefile_objid`
INNER JOIN pdrc_detainees_details_arrest ON pdrc_detainees_details_arrest.detaineeid = pdrc_detainees.`objid`
INNER JOIN etracs254_bukidnon.`entityindividual` xxx ON xxx.`objid` = pdrc_detainees.`objid`
WHERE pdrc_detainees_details_case.`casefile_objid` = $P{casefileid}
${filter}
GROUP BY pdrc_detainees.`objid`


[getPDRCListOfDetaineesByRTC]
SELECT
pdrc_detainees.`detainee_name`,
xxx.`gender`,
pdrc_detainees_details_arrest.`dateofcommitment`,
pdrc_cases.`name` AS Casefilename,
pdrc_detainees_details_case.`criminalcaseno`,
pdrc_detainees_details_hearingdetails.`hearingdate`
FROM pdrc_detainees
INNER JOIN etracs254_bukidnon.`entityindividual` xxx ON xxx.`objid` = pdrc_detainees.`objid`
INNER JOIN pdrc_detainees_details_case ON pdrc_detainees_details_case.`detaineeid` = pdrc_detainees.`objid`
INNER JOIN pdrc_cases ON pdrc_cases.`objid` = pdrc_detainees_details_case.`casefile_objid`
INNER JOIN pdrc_detainees_details_arrest ON pdrc_detainees_details_arrest.`detaineeid` = pdrc_detainees.`objid`
INNER JOIN pdrc_detainees_details_hearingdetails ON pdrc_detainees_details_hearingdetails.`detaineeid` = pdrc_detainees.`objid`
WHERE pdrc_detainees_details_case.`casefile_objid` = $P{casefileid}
${filter}
GROUP BY pdrc_detainees.`objid`



[getPDRCInventoryOfDetainees]
SELECT 
pdrc_detainees.`prisonno`,
pdrc_detainees.`detainee_name`,
xxx.`gender`,
pdrc_cases.`name` AS casefilename,
pdrc_detainees_details_arrest.`dateofcommitment`,
pdrc_detainees_details_arrest.`datereleasedorwaive`
FROM pdrc_detainees
INNER JOIN etracs254_bukidnon.`entityindividual` xxx ON xxx.`objid` = pdrc_detainees.`objid`
INNER JOIN pdrc_detainees_details_case ON pdrc_detainees_details_case.`detaineeid` = pdrc_detainees.`objid`
INNER JOIN pdrc_cases ON pdrc_cases.`objid` = pdrc_detainees_details_case.`casefile_objid`
INNER JOIN pdrc_detainees_details_arrest ON pdrc_detainees_details_arrest.`detaineeid` = pdrc_detainees.`objid`
WHERE pdrc_detainees_details_case.`casefile_objid` = $P{casefileid}
${filter}
GROUP BY pdrc_detainees.`objid`

[getPDRDetainedPrisoners]
SELECT 
pdrc_detainees.`detainee_name`,
xxx.`gender`,
pdrc_cases.`name` AS casefilename,
pdrc_detainees_details_case.`criminalcaseno`,
pdrc_detainees_details_arrest.`dateofcommitment`,
pdrc_detainees_details_arrest.`datereleasedorwaive`
FROM pdrc_detainees
INNER JOIN etracs254_bukidnon.`entityindividual` xxx ON xxx.`objid` = pdrc_detainees.`objid`
INNER JOIN pdrc_detainees_details_case ON pdrc_detainees_details_case.`detaineeid` = pdrc_detainees.`objid`
INNER JOIN pdrc_cases ON pdrc_cases.`objid` = pdrc_detainees_details_case.`casefile_objid`
INNER JOIN pdrc_detainees_details_arrest ON pdrc_detainees_details_arrest.`detaineeid` = pdrc_detainees.`objid`
WHERE pdrc_detainees_details_case.`casefile_objid` = $P{casefileid}
${filter}
GROUP BY pdrc_detainees.`objid`


[getPDRCCrimebyMunicipality]
SELECT
etracs254_bukidnon.`entity_address`.`municipality`,
xxx.`gender`,
pdrc_cases.`name` AS casefilename,
COUNT(pdrc_cases.`objid`) AS total
FROM pdrc_detainees
INNER JOIN etracs254_bukidnon.`entity_address` ON etracs254_bukidnon.entity_address.`objid` = pdrc_detainees.`objid`
INNER JOIN etracs254_bukidnon.`entityindividual` xxx ON xxx.`objid` = pdrc_detainees.`objid`
INNER JOIN pdrc_detainees_details_case ON pdrc_detainees_details_case.`detaineeid` = pdrc_detainees.`objid`
INNER JOIN pdrc_cases ON pdrc_cases.`objid` = pdrc_detainees_details_case.`casefile_objid`
WHERE pdrc_detainees_details_case.`casefile_objid` = $P{casefileid}
${filter}
GROUP BY pdrc_cases.`objid`


[getPDRCSummaryOfCases]
SELECT
pdrc_detainees.`prisonno`,
xxx.`gender`,
pdrc_cases.`name` AS casefilename,
COUNT(pdrc_cases.`objid`) AS total
FROM pdrc_detainees
INNER JOIN etracs254_bukidnon.`entityindividual` xxx ON xxx.`objid` = pdrc_detainees.`objid`
INNER JOIN pdrc_detainees_details_case ON pdrc_detainees_details_case.`detaineeid` = pdrc_detainees.`objid`
INNER JOIN pdrc_cases ON pdrc_cases.`objid` = pdrc_detainees_details_case.`casefile_objid`
GROUP BY pdrc_detainees_details_case.`casefile_objid`