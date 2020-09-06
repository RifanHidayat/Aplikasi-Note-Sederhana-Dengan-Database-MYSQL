<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class RestFullAPi extends CI_Controller {
	public function __construct(){
		parent::__construct();
		$this->load->helper('url');
		$this->load->model('modelnotes');
	}

	public function index()
	{
	 	$response = $this->modelnotes->tampilAll('tb_notes',['id_user'=>$this->input->post('id')])->result();
		echo json_encode($response);
		header('Content-Type: application/json');
	}
	public function login(){
	
		$email=$this->input->post('email');
		$pass=$this->input->post('pass');
		$user=$this->db->get_where('tb_user',['email'=>$email])->row_array();
		// die;
		if ($user){
			if (password_verify($pass,$user['password'])){
				$result['value']=1;
				$result['status']="true";
				$result['message']="Berhasil melakukan Login";
				$result['detail']=$user;
				
				header('Content-Type: application/json');
       		
			}else{
				$result['value']=0;
				$result['status']="false";
				$result['message']="Password yang dimasukkan salah";
				header('Content-Type: application/json');
        				
			}

		}else{		
				$result['value']=0;
				$result['statu']="false";
				$result['message']="Email yang dimasukan tidak tersedia";
			
				header('Content-Type: application/json');
        
		}
		 echo json_encode($result);


	} 

	public function register(){
	
		$email=$this->input->post('email');
	
		$where=array('email'=>$email);
		$cekemail=$this->modelnotes->cek('tb_user',$where);
		if ($cekemail->num_rows()>=1){
			$result['value']=2;
			$result['status']="false";
			$result['message']="email Sudah digunakan";


		}else{

				$data=[
				'nama'=>$this->input->post('nama'),
				'email'=>$this->input->post('email'),
				'jk'=>$this->input->post('jk'),
				'telp'=>$this->input->post('telp'),			
				'password'=> password_hash($this->input->post('pass'), PASSWORD_DEFAULT)
			];
			$daftar=$this->db->insert('tb_user',$data);
			if ($daftar){

			$result['value']=1;	
			$result['status']="true";
			$result['message']="Berhasil melakukan register";


			}else{
			$result['value']=0;	
			$result['status']="false";
			$result['message']="Gagal melakukan register";
			}
		}
	
			echo json_encode($result);
			header('Content-Type: application/json');
		
	
	} 

	public function addNote(){
				$data=[
				'judul'=>$this->input->post('judul'),
				'isi'=>$this->input->post('isi'),
				'id_user'=>$this->input->post('id'),
			
			];
			$add=$this->db->insert('tb_notes',$data);
			if ($add){
			$result['status']="true";
			$result['message']="Berhasil menambahkan note";


			}else{
			$result['status']="false";
			$result['message']="gagal  menambahkan note";
			}
			echo json_encode($result);
			header('Content-Type: application/json');
	}

	public function editNote(){

			$judul=$this->input->post('judul');
			$isi=$this->input->post('isi');
			$id=$this->input->post('id');
			
			$data_update=array(
			'judul'=>$judul,
			'isi'=>$isi
			);
			$where=array(
			'id'=>$id);
			$ubah=$this->modelnotes->update($where,$data_update,'tb_notes');
			$result['status']="true";
			$result['message']="Berhasil merubah data note";	
			echo json_encode($result);
			header('Content-Type: application/json');
		
	}
	public function deleteNote(){

		$id=$this->input->post("id");
		$hapus=$this->modelnotes->delete($id);
		$result['status']="true";
		$result['message']="Berhasil menghapus note";
		echo json_encode($result);
		header('Content-Type: application/json');
		

		
	}
  
}

