SELECT
sales_order.sales_code,
sales_order.sales_id,
sales_order.order_date,
sales_order.due_date,
sales_order.request_ship_date,
sales_order.payment_type,
customers.customers_name,
customer_types.customer_types_name,
sys_status_flows.status_flows_name,
sys_delegation_conf.step_name,
sys_users.username
FROM
sales_order
INNER JOIN customers ON sales_order.customer_id = customers.customers_id
INNER JOIN customer_types ON sales_order.customer_types_id = customer_types.customer_types_id
INNER JOIN sys_status_flows ON sales_order.sales_order_status = sys_status_flows.status_flows_id
LEFT JOIN sys_users ON sys_users.id = sales_order.delegation_reliever_id
LEFT JOIN sys_delegation_conf ON sys_delegation_conf.delegation_for = sales_order.delegation_for 
AND sys_delegation_conf.ref_event_id = sales_order.delegation_ref_event_id 
AND sys_delegation_conf.delegation_version = sales_order.delegation_version 
AND sys_delegation_conf.step_number = sales_order.delegation_step 

WHERE sales_order.`status` = 'Active'
