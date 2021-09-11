User  
id, integer  
name, string  
password_digest, string

Task  
id, integer  
task_name, string  
task_detail, text  
user_id, integer

Label  
id, integer  
label_name, string  
task_id, integer

Task_label  
id, integer  
task_id, integer  
label_id, integer
