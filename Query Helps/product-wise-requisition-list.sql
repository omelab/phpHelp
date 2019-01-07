SELECT
	products.products_id,
	products.products_name,
	purchase_requisition_details.purchase_requisition_details_id,
	SUM(
		purchase_requisition_details.approve_qty
	) AS total_approve_qty,
	GROUP_CONCAT(
		purchase_requisitions.purchase_requisitions_code
	) AS purchase_requisitions_codes,
	GROUP_CONCAT(
		purchase_requisitions.purchase_requisitions_id
	) AS purchase_requisitions_ids,
	COUNT(
		purchase_requisition_details.purchase_requisition_details_id
	) AS total_requisition
FROM
	`products`
INNER JOIN `purchase_requisition_details` ON `purchase_requisition_details`.`products_id` = `products`.`products_id`
INNER JOIN `purchase_requisitions` ON `purchase_requisitions`.`purchase_requisitions_id` = `purchase_requisition_details`.`purchase_requisitions_id`
WHERE
	`purchase_requisitions`.`requisition_status` = 4
AND `products`.`status` = 'Active'
AND `purchase_requisition_details`.`purchase_cs_id` IS NULL
AND `purchase_requisitions`.`created_at` BETWEEN 2019 - 01 - 06
AND 2019 - 01 - 06
GROUP BY
	products.products_id