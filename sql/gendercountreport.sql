[getGenderCountReport]
SELECT 
xx.orgunitid,
xx.name,
xx.effectivefrom,
xx.effectiveuntil, 
COUNT(xx.objid) as subtotal, 
CAST(SUM(IF((xx.gender = "MALE" OR xx.gender = "M") AND xx.status = "JO", 1, 0)) AS SIGNED) AS jom, 
CAST(SUM(IF((xx.gender = "FEMALE" OR xx.gender = "F") AND xx.status = "JO", 1, 0))AS SIGNED) AS jof,
CAST(SUM(IF((xx.gender = "MALE" OR xx.gender = "M") AND xx.status = "CASUAL", 1, 0)) AS SIGNED) AS cam, 
CAST(SUM(IF((xx.gender = "FEMALE" OR xx.gender = "F") AND xx.status = "CASUAL", 1, 0)) AS SIGNED) AS caf    
FROM
(SELECT org.`orgunitid`, org.name, ji.`objid`, ei.`gender`, j.`status`, j.`effectivefrom` as effectivefrom, j.`effectiveuntil` AS effectiveuntil, j.`dateissued`
FROM tagabukid_hrmis.`hrmis_appointmentjoborderitems` ji
INNER JOIN tagabukid_hrmis.`hrmis_appointmentjoborder` j ON j.`objid` = ji.`parentid`
INNER JOIN tagabukid_hrmis.`references_tblorganizationunit` org ON org.`orgunitid` = j.`org_orgunitid`
INNER JOIN etracs254_bukidnon.`entityindividual` ei ON ei.`objid` = ji.`entityid`
WHERE j.`state` = 'DRAFT'
AND NOW() BETWEEN $P{datefrom} AND $P{dateto}
AND org.orgunitid LIKE $P{office}

UNION

SELECT org.`orgunitid`, org.name, ci.`objid`, ei.`gender`, c.`status`, c.`effectivefrom` as effectivefrom, c.`effectiveuntil` AS effectiveuntil, c.`dateissued`
FROM tagabukid_hrmis.`hrmis_appointmentcasualitems` ci
INNER JOIN tagabukid_hrmis.`hrmis_appointmentcasual` c ON c.`objid` = ci.`parentid`
INNER JOIN tagabukid_hrmis.`references_tblorganizationunit` org ON org.`orgunitid` = c.`org_orgunitid`
INNER JOIN etracs254_bukidnon.`entityindividual` ei ON ei.`objid` = ci.`personnel_objid`
WHERE c.`state` = 'DRAFT'
AND NOW() BETWEEN $P{datefrom} AND $P{dateto}
AND org.orgunitid LIKE $P{office})xx
GROUP BY xx.name

[getOrgOffice]
SELECT * FROM references_tblorganizationunit