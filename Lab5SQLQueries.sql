--- Question 1
select school_nam 
from publicschools
where st_equals(geom, ST_GeometryFromText('POINT(413797.20 124604.24)', 26985))

--- Question 2
select school_nam 
from publicschools
where st_dwithin(geom, ST_GeometryFromText('POINT(413797 124604)', 26985), 1000)

--- Question 3
select geodesc
from pgcensustract
where st_contains(geom, ST_GeometryFromText('POINT(413797 124604)', 26985))

--- Question 4
select *
from pgroads
where st_Dwithin(geom, ST_GeometryFromText('POINT(406286 124178)', 26985), 5000)

--- Question 5
select fename, fetype
from pgroads
where st_Dwithin(geom, (select geom from publicschools where school_nam = 'Baden' AND city = 'Brandywine'), 1000)

--- Question 6
select a.geodesc, count(b.gid) as SchoolCount
from pgcensustract as a
join publicschools as b
on ST_contains(a.geom, b.geom)
group by a.geodesc
order by a.geodesc

--- Question 7
select pgcensustract.geodesc, pgroads.cfcc, count(distinct publicschools.school_nam) as schoolcount
from pgcensustract
left join publicschools
on pgcensustract.geodesc = publicschools.geodesc
left join pgroads
on ST_Intersects(pgcensustract.geom, pgroads.geom)
group by pgcensustract.geodesc, pgroads.cfcc