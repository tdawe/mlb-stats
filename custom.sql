alter table Batting add AVG double;
alter table Batting add SLG double;
update batting set AVG = ((H+0.0)/(AB));
update Batting set SLG = ("2B"*2 + "3B"*3 + HR*4.0 + (H-"2B"-"3B"-HR)) / AB;
