<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require APPPATH . 'models/Db_model.php';

class User_model extends Db_model {

	public function __construct()
	{
		parent::__construct();

		$this->table = $this->users_table;
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

	public function create($data)
	{	
		// Exit whether there is an empty data
		foreach ($data as $value) {
			if ($value == NULL)
				return FALSE;
		}

		// Exit whether email exists
		if (
			$this->db
				->where('email', $data['email'])
				->count_all_results($this->table) > 0
		)
			return FALSE;

		// Save only nice data
		$data['email']			= strtolower($data['email']);
		$data['password']		= password_hash($data['password'], PASSWORD_DEFAULT);
		$data['is_verified']	= FALSE;
		$data['created_at']		= date('Y-m-d H:i:s');
		$data['updated_at']		= $data['created_at'];

		return $this->db
			->insert($this->table, $data);
	}

	public function update($set, $where)
	{
		// Exit whether there is an empty data
		foreach ($set as $value) {
			if ($value == NULL)
				return FALSE;
		}

		foreach ($where as $value) {
			if ($value == NULL)
				return FALSE;
		}

		// Exit whether new email exists
		if (
			$set['email'] != $where['email']
			AND
			$this->db
				->where('email', $set['email'])
				->count_all_results($this->table) > 0
		)
			return FALSE;

		// If valid login, update data
		if ($this->login(array(
			'email'		=> $where['email'],
			'password'	=> $where['password']
		)))
		{
			$set['password']	= password_hash($set['password'], PASSWORD_DEFAULT);
			$set['updated_at']	= date('Y-m-d H:i:s');

			return $this->db
				->set($set)
				->where('email', $where['email'])
				->update($this->table);
		}

		return FALSE;
	}

	public function delete($id)
	{
		return $this->db
			->where('id', $id)
			->delete($this->table);
	}

	public function login($data)
	{
		// Exit whether there is an empty data
		foreach ($data as $value) {
			if ($value == NULL)
				return FALSE;
		}

		// Get the hash
		$hash = $this->db
			->select('password')
			->where('email', $data['email'])
			->get($this->table)->row();

		if ($hash == NULL)
			return FALSE;

		// Verify
		return password_verify($data['password'], $hash->password);
	}

}
