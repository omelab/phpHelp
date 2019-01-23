<?php
$data['products'] = DB::table('products')
                ->select(
                    'products.products_id',
                    'products.products_name',
                    'products.sku_name',
                    'products.is_trackable',
                    'products.product_uoms',
                    'products_in_stocks.current_stock_qty',
                    'sales_order.sales_id',
                    'sales_order_details.order_qty',
                    'sales_order_details.approve_qty',
                    'sales_order_details.chalan_qty'
                )
                ->join('sales_order_details', 'products.products_id', '=', 'sales_order_details.product_id')
                ->join('sales_order', 'sales_order_details.sales_order_id', '=', 'sales_order.sales_id')
                ->leftJoin('products_in_stocks', 'sales_order.warehouses_id', '=', 'products_in_stocks.warehouses_id')
                ->where('sales_order.sales_id', $reference_id)
                ->whereRaw('sales_order_details.approve_qty > sales_order_details.chalan_qty')
                ->where('sales_order.status', 'Active')
                ->get();

// Baserd on Sales Order Table
$data['products'] = DB::table('sales_order')
->select(
    'sales_order.sales_id',
    'products.products_id',
    'products.products_name',
    'products.sku_name',
    'products.is_trackable',
    'products.product_uoms',
    'sales_order_details.order_qty',
    'sales_order_details.approve_qty',
    'sales_order_details.chalan_qty',
    'products_in_stocks.current_stock_qty'
)
->join('sales_order_details', 'sales_order.sales_id', '=', 'sales_order_details.sales_order_id')
->join('products', 'sales_order_details.product_id', '=', 'products.products_id')
->leftJoin('products_in_stocks', 'sales_order.warehouses_id', '=', 'products_in_stocks.warehouses_id')
->where('sales_order.sales_id', $reference_id)
->whereRaw('sales_order_details.approve_qty > sales_order_details.chalan_qty')
->where('sales_order.status', 'Active')
->get();