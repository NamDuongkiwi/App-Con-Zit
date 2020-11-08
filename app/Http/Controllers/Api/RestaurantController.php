<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class RestaurantController extends Controller
{
    //
    public function list_res(){
        $id = request('id');
        $data = \DB::table('cuahang_loaidoan')
            ->join('cua_hang', 'cua_hang.id_cuahang', '=', 'cuahang_loaidoan.id_cuahang')
            ->select('cua_hang.*')
            ->where('id_loaidoan', $id)
            ->get();
        return $data;
        //return \DB::table('cua_hang')->select('cua_hang.*')->get();
    }

    public function listfood(){
        $id = request('id');
        return \DB::table('mon_an')
            ->where('id_cuahang', $id)->get();
    }
    
    public function getpage($page){
        $class = \DB::table('class')
            ->join('teacher', 'teacher.teacher_id', '=', 'class.teacher_id')
            ->join('subject', 'subject.subject_id', '=','class.subject_id' )
            ->select('class.class_id', 'subject.subject_name', 'class.max_student',
                'class.room', 'class.day','class.start_class','class.end_class', 'teacher.name as teacher_name')
            ->offset(($page-1)*10)
            ->limit(10)
            ->get();
        return $class;
    }
}
