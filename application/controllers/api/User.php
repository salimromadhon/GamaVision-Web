<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require APPPATH . 'libraries/REST_Controller.php';

class User extends REST_Controller {

	public function __construct()
	{
		parent::__construct();

		$this->load->model('User_model', 'User');
	}

	/*
	 * Get User Data
	 */
	public function index_get()
	{
		$id = $this->get('id');

		// If the id parameter doesn't exist return all the users

		if ($id === NULL)
		{
			$users = $this->User->get_all();

			// Check if the users data store contains users (in case the database result returns NULL)
			if ($users)
			{
				// Set the response and exit
				$this->response($users, REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
			}
			else
			{
				// Set the response and exit
				$this->response([
					'status' => FALSE,
					'message' => 'No users were found'
				], REST_Controller::HTTP_NOT_FOUND); // NOT_FOUND (404) being the HTTP response code
			}
		}
		else
		{
			$id = (int) $id;

			// Validate the id.
			if ($id <= 0)
			{
				// Invalid id, set the response and exit.
				$this->response(NULL, REST_Controller::HTTP_BAD_REQUEST); // BAD_REQUEST (400) being the HTTP response code
			}

			$user = $this->User->get_single($id);

			if ($user)
			{
				// Set the response and exit
				$this->response($user, REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
			}
			else
			{
				// Set the response and exit
				$this->response([
					'status' => FALSE,
					'message' => 'No user was found'
				], REST_Controller::HTTP_NOT_FOUND); // NOT_FOUND (404) being the HTTP response code
			}
		}
	}

	/*
	 * Create New User
	 */
	public function create_post()
	{
		$data = array(
			'name'		=> $this->post('name'),
			'email'		=> $this->post('email'),
			'password'	=> $this->post('password'),
			'role_id'	=> $this->post('role_id')
		);

		if ($this->User->create($data))
		{
			$data['status'] = TRUE;
			$this->set_response($data, REST_Controller::HTTP_CREATED);
		}
		else
			$this->response(NULL, REST_Controller::HTTP_BAD_REQUEST);
	}

	/*
	 * Modify User
	 */
	public function update_post()
	{
		$set = array(
			'name'		=> $this->post('name'),
			'email'		=> $this->post('email'),
			'password'	=> $this->post('password'),
			'role_id'	=> $this->post('role_id')
		);

		$where = array(
			'email'		=> $this->post('current_email'),
			'password'	=> $this->post('current_password')
		);

		if ($this->User->update($set, $where))
		{
			$set['status'] = TRUE;
			$this->set_response($set, REST_Controller::HTTP_OK);
		}
		else
			$this->response(NULL, REST_Controller::HTTP_BAD_REQUEST);
	}

	/*
	 * Delete User
	 */
	public function delete_delete()
	{
		$id = (int) $this->get('id');

		if ($id <= 0)
			$this->response(NULL, REST_Controller::HTTP_BAD_REQUEST);

		$data = $this->User->get_single($id);

		if ($data == NULL)
			$this->response(NULL, REST_Controller::HTTP_BAD_REQUEST);

		if($this->User->delete($id))
		{
			$data->status = TRUE;
			$this->response($data, REST_Controller::HTTP_OK);
		}
		else
			$this->response(NULL, REST_Controller::HTTP_BAD_REQUEST);
	}

	/*
	 * Login Handler
	 */
	public function login_post()
	{
		$data = array(
			'email'		=> $this->post('email'),
			'password'	=> $this->post('password')
		);

		if ($this->User->login($data))
		{
			$data['status'] = TRUE;
			$this->response($data, REST_Controller::HTTP_OK);
		}
		else
			$this->response(NULL, REST_Controller::HTTP_BAD_REQUEST);
	}

}
