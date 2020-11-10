<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use http\Env\Response;
use Illuminate\Http\Request;

class RestaurantController extends Controller
{
    //
    public function list_res(Request $request){
        $id = $request->get('id');
        return \DB::select(\DB::raw("CALL list_res($id)"));
    }

    public function listfood()
    {
        $id = request('id');
        return \DB::select(\DB::raw("CALL list_food($id)"));
    }
    public function orders(Request $request){
        $userid = $request->header('id');
        $foodid = $request->get('food_id');
        $num = $request->get('num');
        $orderid = $request->get('order_id');
        \DB::table('don_hang')->insert(
            ['id_donhang'=> $orderid, 'id_khachhang'=>$userid, 'id_monan'=>$foodid, 'soluong'=>$num]
        );
        return response()->json(['mess'=>'success'], 200);
    }
    public function temp(){
        $value = 1;
        return json_decode($value, true);
    }




    public function getorderid(){
        $id_donhang = \DB::table('don_hang')->select('id_donhang')
            ->orderBy('id_donhang', 'desc')
            ->limit(1)->get('id_donhang');
        return $id_donhang;
    }

    public function getcategory(Request $request){
        $id = $request->get('id');
        return \DB::table('cuahang_loaidoan')
            ->join('loai_do_an', 'loai_do_an.id_loaidoan', '=', 'cuahang_loaidoan.id_loaidoan')
            ->select('loai_do_an.ten_loaidoan')
            ->where('cuahang_loaidoan.id_cuahang', $id)
            ->get();
    }
    public function findname(Request $request){
        $name = $request->get('name');
        return \DB::select(\DB::raw("CALL list_res_by_name($name)"));
    }
}
