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
        $id_donhang = \DB::table('don_hang')->select('id_donhang')
            ->orderBy('id_donhang', 'desc')
            ->limit(1)->get('id_donhang');
        $id = $request->header('id');
        $json = json_decode($request->getContent());
        /*foreach ($json as $key => $value){
            foreach ($value as $a => $b){
                \DB::table('don_hang')->insert([
                    ['id_donhang' => , 'votes' => 0],
                ]);
            }
        }*/
        //$x = json_decode($id_donhang, true);

        return $id_donhang['id_donhang'];


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
