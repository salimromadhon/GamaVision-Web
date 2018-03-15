<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Db_model extends CI_Model {

	/*
	 * Database Implementation
	 *
	 */
	protected $users_table		= 'users';
	protected $api_users_table	= 'api_users';

	public function __construct()
	{
		parent::__construct();
	}

}
