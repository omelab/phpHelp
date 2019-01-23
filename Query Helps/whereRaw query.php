<?php
$market_records = Market::where('seller_id', '!=', Auth::user()->id)->whereRaw('seller_id = buyer_id')->get();