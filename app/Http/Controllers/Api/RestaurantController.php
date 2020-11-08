<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class RestaurantController extends Controller
{
    //
    public function list(){
        /*$id = request('id_loaidoan');
        $data = \DB::table('cuahang_loaidoan')
            ->join('cua_hang', 'cua_hang.id_cuahang', '=', 'cuahang_loaidoan.')
            ->select('cua_hang.*')
            ->where('id_loaidoan', $id);
        return $data;*/
        $data = \DB::table('cua_hang')->select('cua_hang.*');
        return $data;
    }
}
