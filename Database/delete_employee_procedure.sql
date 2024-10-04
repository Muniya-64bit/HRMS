delimiter //
create procedure delete_employee(
    in p_employee_id varchar(40),
    in d_employee_id varchar(40)
)
begin
	if (select is_admin from user_access where username = (select username from users where employee_id= p_employee_id)) = true then
		delete from employee where employee_id = d_employee_id;
	end if;
end //
delimiter ;
