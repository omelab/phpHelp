SELECT
	`sales_order`.`sales_id`,
	`sales_order`.`sales_code`,
	`sales_order`.`order_date`,
	`sales_order`.`due_date`,
	`sales_order`.`request_ship_date`,
	`sales_order`.`payment_type`,
	`sales_order`.`sales_order_status`,
	`customers`.`customers_name`,
	`customer_types`.`customer_types_name`,
	`sys_status_flows`.`status_flows_name`,
	`sys_delegation_conf`.`step_name`,
	`sys_users`.`username`
FROM
	`sales_order`
INNER JOIN `customers` ON `sales_order`.`customer_id` = `customers`.`customers_id`
INNER JOIN `customer_types` ON `sales_order`.`customer_types_id` = `customer_types`.`customer_types_id`
LEFT JOIN `sys_status_flows` ON `sys_status_flows`.`status_flows_id` = `sales_order`.`sales_order_status`
LEFT JOIN `sys_users` ON `sales_order`.`delegation_reliever_id` = `sys_users`.`id`
LEFT JOIN `sys_delegation_conf` ON `sales_order`.`delegation_for` = `sys_delegation_conf`.`delegation_for`
AND `sales_order`.`delegation_ref_event_id` = `sys_delegation_conf`.`ref_event_id`
AND `sales_order`.`delegation_version` = `sys_delegation_conf`.`delegation_version`
AND `sales_order`.`delegation_step` = `sys_delegation_conf`.`step_number`
WHERE
	`sales_order`.`status` = 'Active'
AND `sales_order`.`payment_type` = 'Cash'
AND `sales_order`.`sales_order_status` = 30
AND `sales_order`.`created_by` = 23
AND `sales_order`.`created_at` BETWEEN '2019-1-01'
AND '2019-1-30'
GROUP BY
`sales_order`.`sales_id`,
`sales_order`.`sales_code`,
`sys_users`.`username`