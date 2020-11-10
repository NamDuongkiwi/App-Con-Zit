<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
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
        $json = json_decode($request->getContent(), true);

    }

    public function getcategory(Request $request){
        $id = $request->get('id');
        return \DB::table('cuahang_loaidoan')
            ->join('loai_do_an', 'loai_do_an.id_loaidoan', '=', 'cuahang_loaidoan.id_loaidoan')
            ->select('loai_do_an.ten_loaidoan')
            ->where('cuahang_loaidoan.id_cuahang', $id)
            ->get();
    }


}
