with
goodjobs as (
    select j.jid, oaCount, int1Count, int2Count, int3Count, offerCount from jobs j
    left join (select jid, count(*) as oaCount from Contributions where oa='t' group by jid) oa on j.jid = oa.jid
    left join (select jid, count(*) as int1Count from Contributions where InterviewStage>=1 group by jid) int1 on j.jid = int1.jid
    left join (select jid, count(*) as int2Count from Contributions where InterviewStage>=2 group by jid) int2 on j.jid = int2.jid
    left join (select jid, count(*) as int3Count from Contributions where InterviewStage>=3 group by jid) int3 on j.jid = int3.jid
    left join (select jid, count(*) as offerCount from Contributions where offercall='t' group by jid) offer on j.jid = offer.jid
),
watches as (
    select *, TRUE as watch from Watching where UID = 'j12cole'
)
select j.*, g.oacount, g.int1count, g.int2count, g.int3count, g.offercount, coalesce(w.watch, false) watched
from jobs j left join goodjobs g on j.jid = g.jid left join watches w on j.jid = w.jid order by j.jid
