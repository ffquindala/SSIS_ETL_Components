SET LANGUAGE 'Brazilian'
declare @startDate date;
declare @endDate date;

select @startDate = '20130101';
select @endDate = '20301231';

with dateRange as
(
  select dt = @startDate
  where @startDate < @endDate
  union all
  select dateadd(dd, 1, dt)
  from dateRange
  where dateadd(dd, 1, dt) <= @endDate
)
	select
		dt AS Data
from dateRange
OPTION (MAXRECURSION 0)




-- DIM_TEMPO
USE [COMERCIAL_SALES_STAGE]
GO
SELECT FORMAT(MIN([Date]), 'yyyyMMdd') FROM [dbo].[VENDAS]
GO

SET LANGUAGE 'Brazilian'
declare @startDate date;
declare @endDate date;

select @startDate = (SELECT FORMAT(MIN([Date]), 'yyyyMMdd') FROM [dbo].[VENDAS]);
select @endDate = '20301231';

with dateRange as
(
  select dt = @startDate
  where @startDate < @endDate
  union all
  select dateadd(dd, 1, dt)
  from dateRange
  where dateadd(dd, 1, dt) <= @endDate
)
	select
		convert(int, format(dt, 'yyyyMMdd')) as SKData,
		dt AS Data,
		DATEPART(YEAR, dt) as Ano,
		CASE
		WHEN DATEPART(QUARTER, dt) IN(1,2) THEN 1
		ELSE 2
		END AS SemestreNum,
		CASE
		WHEN (convert(varchar(1),DATEPART(QUARTER, dt))) IN(1,2) THEN '1° Semestre'
		ELSE '2° Semestre'
		END AS Semestre,
		DATEPART(QUARTER, dt) AS TrimestreNum,
			(convert(varchar(1),DATEPART(QUARTER, dt)) + '° Trimestre') AS Trimestre,
		DATEPART(month, dt) as MesNum,
		DATENAME(month, dt) as Mes,
		DATEPART(day, dt) as dia,
		DATEPART(Weekday, dt) as DiaSemanaNum,
		case
		 when datepart(weekday, dt) = 1 then 'Domingo'
		 when datepart(weekday, dt) = 2 then 'Segunda'
		 when datepart(weekday, dt) = 3 then 'Terça'
		 when datepart(weekday, dt) = 4 then 'Quarta'
		 when datepart(weekday, dt) = 5 then 'Quinta'
		 when datepart(weekday, dt) = 6 then 'Sexta'
	     when datepart(weekday, dt) = 7 then 'Sábado'
		end as DiaSemana,
		DATEPART(week, dt) as SemanaAnoNum,
		(convert(varchar(3), DATEPART(week, dt)) + '° Semana') as SemanaAno
from dateRange
OPTION (MAXRECURSION 0)