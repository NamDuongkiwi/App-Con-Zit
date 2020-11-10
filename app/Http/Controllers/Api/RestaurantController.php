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
    //public function


}
