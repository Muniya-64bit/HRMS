/*create user account*/
delimiter //
create procedure create_user_account(
    in username varchar(40),
    in password varchar(255),
    in p_employee_id varchar(40),
    in access_level varchar(40)
)
begin
    if access_level = 'Admin' then
        insert into users (username, password, employee_id ,profile_visibility_access,profile_editing_access,other_profile_editing_access)
		values (username, password, p_employee_id,true,true,true);
        insert into user_access (username, is_admin,is_supervisor)values (username, true,false);
    elseif access_level = 'Supervisor' then
		insert into users (username, password, employee_id ,profile_visibility_access,profile_editing_access,other_profile_editing_access)
		values (username, password, p_employee_id,true,false,true);
        insert into user_access (username, is_admin,is_supervisor)values (username, false,true);
    else
        insert into users (username, password, employee_id ,profile_visibility_access,profile_editing_access,other_profile_editing_access)
		values (username, password, p_employee_id,false,false,false);
        insert into user_access (username, is_admin,is_supervisor)values (username,false,false);
    end if;
end;
//
delimiter ;
