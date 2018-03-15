<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require APPPATH . 'models/Db_model.php';

class API_User_model extends Db_model {

	public function __construct()
	{
		parent::__construct();

		$this->table = $this->api_users_table;
	}

	public function get_all()
	{
		return $this->db->get($this->table)->result();
	}

	public function get_single($id)
	{
		return $this->db
			->where('id', $id)
			->get($this->table)->row();
	}

}
