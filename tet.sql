delimiter //
drop table if exists t_field;//
create table t_field (
	x int,
	y int,
	value int
);//

drop procedure if exists t_genField;//
create procedure t_genField()
begin
	declare x int;
	declare y int;
	set x = 0;
	set y = 0;
	delete from t_field;
	while x < 10 do
		while y < 20 do 
			insert into t_field (x,y, value) values (x, y, 0);
			set y = y + 1;
		end while;
		set x =  + 1;
		set y = 0;
	end while;	
end;//

drop procedure if exists t_genRandValue;//
create procedure t_genRandValue()
begin
	declare tmpx int;
	declare tmpy int;
	set tmpx = (select rand() * 10);
	set tmpy = (select rand() * 20);
	update t_field set value = 1 where (x = tmpx) and (y = tmpy);
end;//


drop procedure if exists t_showField;//
create procedure t_showField()
begin
	declare x_ int;
	declare y_ int;
	declare str varchar(200);
	declare tmp int;
	declare new_char varchar(1);
	set x_ = 0;
	set y_ = 0;
	set str = '';
	set str = concat_ws('',str,"\n");
	while y_<20 do
		while x_<10 do
			set tmp = (select value from t_field where (x=x_) and (y=y_));

			if (tmp = 1) then
				set new_char = 'W';
			else
				set new_char = '_';
			end if;

			set str = concat_ws('',str, new_char);
			set x_ = x_ + 1;
		end while;
		set str = concat_ws('',str,"\n");
		set y_ = y_ + 1;
		set x_ = 0;
	end while;
	select str;
end;//
delimiter ;
