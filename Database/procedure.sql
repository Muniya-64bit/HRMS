/* add new employee */
delimiter //
create procedure add_employee (
    in employee_id varchar(40),
    in first_name varchar(40),
    in last_name varchar(40),
    in birthday date,
    in nic varchar(40),
    in gender varchar(40),
    in marital_status varchar(40),
    in number_of_dependents int,
    in address varchar(40),
    in contact_number varchar(40),
    in business_email varchar(40),
    in p_job_title varchar(40),
	in p_employee_status varchar(40),
    in dept_name varchar(40),
    in brch_name varchar(40),
    in p_profile_photo varchar(40),
	in emergency_contact_name varchar(40),
	in emergency_contact_nic varchar(40),
	in emergency_contact_address varchar(40),
    in emergency_contact_number varchar(40)
)
begin
    declare p_position_id int;
    declare p_department_id int;
    declare p_branch_id int;
	declare p_pay_grade int;
    declare p_annual_leave_count int;
    declare p_casual_leave_count int;
    declare p_maternity_leave_count int;
    declare p_nopay_leave_count int;
    declare p_leave_type_id int;
    
    select department_id
    into p_department_id
    from department
    where department_name = dept_name;

    select branch_id
    into p_branch_id
    from branch
    where branch_name = brch_name;
    
    select pay_grade
    into p_pay_grade
    from employee_position
    where job_title = p_job_title
    and employee_status = p_employee_status ;
	
    select annual_leave_count
    into p_annual_leave_count
    from leave_limit
    where pay_grade = p_pay_grade;
    
    select casual_leave_count
    into p_casual_leave_count
    from leave_limit
    where pay_grade = p_pay_grade;
    
    select maternity_leave_count
    into p_maternity_leave_count
    from leave_limit
    where pay_grade = p_pay_grade;
    
    select nopay_leave_count
    into p_nopay_leave_count
    from leave_limit
    where pay_grade = p_pay_grade;
    
    select leave_type_id
    into p_leave_type_id
    from leave_limit
    where pay_grade = p_pay_grade;
    
    insert into employee (
        employee_id, first_name,last_name, birthday, employee_nic, gender, marital_status, number_of_dependents,
        address, contact_number,business_email,job_title,department_id, branch_id, profile_photo
    ) 
    values (
        employee_id,first_name,last_name, birthday, nic, gender, marital_status, number_of_dependents,
        address, contact_number,business_email, p_job_title,p_department_id, p_branch_id,p_profile_photo
    );
    insert into emergency_contact (emergency_contact_id,name, nic, address, emergency_contact_number)
    values (employee_id,emergency_contact_name,emergency_contact_nic,emergency_contact_address, emergency_contact_number);
    
    insert into leave_count_record (employee_id, leave_type_id, annual_leave_remaining, casual_leave_remaining, maternity_leave_remaining, nopay_leave_remaining)
	values(employee_id, p_leave_type_id, p_annual_leave_count, p_casual_leave_count, p_maternity_leave_count, p_nopay_leave_count);
end //
delimiter ;