[getPDRCMasterListByGender]
SELECT xx.dno,
xx.detainee_lastname,
xx.detainee_firstname,
xx.detainee_middlename,
xxx.`gender`,
ccc.`name` AS casefilename
FROM pdrc_detainees xx
INNER JOIN pdrc_detainees_details_case cc ON cc.`detaineeid` = xx.`objid`
INNER JOIN pdrc_cases ccc ON ccc.`objid` = cc.`casefile_objid`
INNER JOIN etracs254_bukidnon.`entityindividual` xxx ON xxx.`objid` = xx.`objid`
WHERE cc.`casefile_objid` = $P{casefileid}
${filter}
GROUP BY xx.`objid`
