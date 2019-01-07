SELECT
	product_categorys.product_categorys_id as sub_category_of,
	CONCAT(
		CASE WHEN `parents` is null THEN '' ELSE CONCAT(`parents`,'>') END,
		COALESCE(`product_categorys_name`,'')
	) AS product_categorys_name

FROM
	product_categorys