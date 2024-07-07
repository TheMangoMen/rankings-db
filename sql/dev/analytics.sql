select
c.jid,
case
    when BOOL_OR(c.offercall) then 'offercall'
    when max(c.interviewstage) > 0 then 'interview'
    when BOOL_OR(c.oa) then 'oa'
end as status
from users u join watching w ON w.uid = u.uid join contributions c on w.jid = c.jid
where u.uid = 'aopal' group by c.jid;

with statuses as (
    select 'oa' as status, 1 as rank
    union
    select 'interview', 2
    union
    select 'offercall', 3
    union
    select 'nothing', 4
),
watched_status as (
    select
    c.jid,
    case
        when BOOL_OR(c.offercall) then 'offercall'
        when max(c.interviewstage) > 0 then 'interview'
        when BOOL_OR(c.oa) then 'oa'
        else 'nothing'
    end as status
    from users u join watching w ON w.uid = u.uid left join contributions c on w.jid = c.jid
    where u.uid = 'njchen' group by c.jid
),
status_counts as (
    select status, count(status) as count
    from watched_status
    group by status
)
select s.status, coalesce(sc.count, 0) as count
from statuses s left outer join status_counts sc on s.status = sc.status
order by s.rank;


select *
from users u join watching w ON w.uid = u.uid join contributions c on w.jid = c.jid order by u.uid;
