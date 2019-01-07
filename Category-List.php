<?php
class Product_categoryController extends Controller
{
    //Add Product Category
    public function create($id = ''){
        $data['page_title'] = $id !=''?'Edit Products Category' :'Create Products Category';

        if ($id !=''){
            $data['category'] = DB::table('product_categorys')->where('product_categorys_id', $id)->first();
            $data['subtype_of_lsit'] = $this->buildList(0, $data['category']->sub_type_of, $data['category']->product_categorys_id);
        }else{
            $data['subtype_of_lsit'] = $this->buildList(0);
        }

        return view('Product_category.entry', $data);
    }

    //Build LIst
    public function buildList($sub_type_of = 0, $selected = null, $accept = '', $parent = '' ){
        $string ='';
        $checked = '';
        $lists = DB::table('product_categorys')->where('sub_type_of', $sub_type_of)->where('product_categorys_id', '!=',$accept)->where('status','Active')->get();
        if (count($lists)){
            $string .= $sub_type_of == 0 ? '<ul class="sub-type-list">':'<ul>';

            foreach ($lists as $i => $list) {

                if ($parent =='' && $i ==0){
                    $parent = $list->sub_type_of;
                }elseif($i ==0){
                    $parent = $parent . ' > '.  $list->sub_type_of;
                }

                $string .= '<li>';
                if($selected == $list->product_categorys_id ){
                    $checked ='checked';
                }else{
                    $checked ='';
                }

                $string .= '<label for="cat'. $list->product_categorys_id .'" data-id="'. $list->product_categorys_id .'" data-parent="'. $parent .'"><input type="radio" name="sub_type_of" value="'.$list->product_categorys_id.'" id="cat'. $list->product_categorys_id .'" '. $checked .'> '.$list->product_categorys_name .' </label>';

                if (!empty($list->product_categorys_id)) {
                    $string .= $this->buildList($list->product_categorys_id, $selected, $accept, $parent);
                }

                $string .= '</li>';
            }
            $string .= '</ul>';
        }
        return $string;
    }

    //Store Product Category
    public function store(Request $request){
        $insertData = array(
            'product_categorys_name'    => $request->product_categorys_name,
            'sub_type_of'               => $request->sub_type_of,
            'parents'                   => $request->parents !=0 ? $request->parents:null,
            'description'               => $request->description,
            'status'                    => $request->status,
            'created_at'                => date('Y-m-d'),
            'created_by'                => Auth::id(),
        );
        DB::table('product_categorys')->insert($insertData);
        return redirect()->route('grid', 'product_category')->with('success','Product Category Added Successfully');
    }

    //Update Product Category
    public function update(Request $request, $id){
        $updateData = array(
            'product_categorys_name'    => $request->product_categorys_name,
            'sub_type_of'               => $request->sub_type_of,
            'parents'                   => $request->parents !=0 ? $request->parents:null,
            'description'               => $request->description,
            'status'                    => $request->status,
            'updated_at'                => date('Y-m-d'),
            'updated_by'                => Auth::id(),
        );

        DB::table('product_categorys')->where('product_categorys_id', $id)->update($updateData);

        return redirect()->route('grid', 'product_category')->with('success','Product Category Update Successfully');
    }

    public function saveProductCategory(Request $request)
    {
        $parents = DB::table('product_categorys')->where('product_categorys_id', '=', $request->sub_category_of)->get();
        //dd($parents);
        $requests = array_merge(
            $request->except('tableName', '_token', 'updated_at', 'pkId', 'primaryKey','route_name'),
            array(
                'parents' => $parents[0]->parents,
                'created_at' => date('Y-m-d'),
                'created_by' => Auth::id(),
            )
        );
        if ($request->primaryKey > 0) {
            DB::table($request->tableName)->where($request->tableName . '_id', '=', $request->primaryKey)
                ->update($requests);
        } else {
            DB::table($request->tableName)->insert($requests);
        }
        return Redirect::to($request->tableName)->with('message', 'Data successfully save');
    }
}
