User  
id, integer  
name, string  
password_digest, string

Task  
id, integer  
title, string  
content, text  
user_id, integer

Label  
id, integer  
label_name, string  
task_id, integer

Task_label  
id, integer  
task_id, integer  
label_id, integer
