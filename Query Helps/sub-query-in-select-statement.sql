SELECT 
 product_categorys.*, product_categorys.sub_type_of as sub, 
 (SELECT product_categorys.product_categorys_name FROM product_categorys
   WHERE product_categorys.product_categorys_id = sub
  ) as sub_type_name
FROM `product_categorys`
WHERE product_categorys_id = 13


/* Ref : http://www.expertphp.in/article/laravel-how-to-use-subquery-in-select-statement-with-example */