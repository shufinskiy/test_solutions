--Сделать выборку содержащую сколько рабочих дней было у каждого поставщика
select 
	tcwd."name",
	COUNT(*) as cnt_days
from 
	t_contractor_work_day tcwd 
group by 
	tcwd."name";

--Сделать выборку поставщиков, у которыйх было больше 10 рабочих дней за январь 2019 года
select 
	tcwd."name"
from 
	t_contractor_work_day tcwd
where 
	tcwd.date_begin::DATE <= '2019-01-31'
group by 
	tcwd."name"
having COUNT(tcwd.date_begin) > 10;

--Сделать выборку поставщиков, кто работал 14, 15 и 16 января 2019 года
select 
	tcwd."name"
from 
	t_contractor_work_day tcwd
where 
	tcwd.date_begin::DATE between '2019-01-14' and '2019-01-16'
group by 
	tcwd."name"
having COUNT(tcwd.date_begin) = 3;
	

--Но если считать, что в конкретный день хотя бы минуту кто-то был на работе, тогда у поставщика 3 тоже все 3 дня рабочие.
select 
	tcwd."name",
	date_trunc('day', tcwd.date_begin) as dt
from 
	t_contractor_work_day tcwd
where 
	tcwd.date_begin::DATE between '2019-01-14' and '2019-01-16'
union 
select 
	tcwd."name",
	date_trunc('day', tcwd.date_end) as dt
from 
	t_contractor_work_day tcwd
where 
	tcwd.date_end::DATE between '2019-01-14' and '2019-01-16';
