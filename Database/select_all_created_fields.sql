delimiter //

create procedure select_employee_details (
    in p_employee_id varchar(40)
)
begin
    select
        employee.employee_id,
        employee.first_name,
        employee.last_name,
        employee.birthday,
        employee.employee_nic,
        employee.gender,
        employee.marital_status,
        employee.number_of_dependents,
        employee.address,
        employee.contact_number,
        employee.business_email,
        employee.job_title,
        employee_position.employee_status,
        department.department_name,
        branch.branch_name,
		employee.profile_photo,
        emergency_contact.name,
        emergency_contact.nic,
        emergency_contact.address,
        emergency_contact.emergency_contact_number
    from employee 
    left join department using(department_id)
    left join branch using (branch_id)
    left join emergency_contact on employee.employee_id = emergency_contact.emergency_contact_id
    left join employee_position using (job_title)
    where employee.employee_id = p_employee_id;
end //
delimiter ;
