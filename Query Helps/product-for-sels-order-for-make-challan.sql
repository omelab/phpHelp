SELECT
	`sales_order_details`.`sales_order_id`,
	`sales_order_details`.`order_qty`,
	`sales_order_details`.`approve_qty`,
	`sales_order_details`.`chalan_qty`,
	`products`.`products_id`,
	`products`.`products_name`,
	`products`.`sku_name`,
	`products`.`is_trackable`,
	`products`.`product_uoms`,
	`products_in_stocks`.`current_stock_qty`
	
FROM
	`sales_order_details`
INNER JOIN `products` ON `sales_order_details`.`product_id` = `products`.`products_id`
INNER JOIN `sales_order` ON `sales_order_details`.`sales_order_id` = `sales_order`.`sales_id`
INNER JOIN `products_in_stocks` ON `sales_order`.`warehouses_id` = `products_in_stocks`.`warehouses_id` AND `sales_order_details`.`product_id`  = `products_in_stocks`.`products_id` 
WHERE
	`sales_order_details`.`sales_order_id` = 3
AND sales_order_details.approve_qty > sales_order_details.chalan_qty
AND `sales_order_details`.`status` = 'Active'