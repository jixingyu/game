<?php
/**
 *
 * Find tag model
 *
 * @author  Xy Ji
 */
class Find_tag_model extends MY_Model
{
    public $table = 'find_tag';

    public function get_tags() {
    	$res = array();
    	$this->db->select(array('id', 'name'));
        $this->db->from($this->table);

        $result = $this->db->get()->result_array();
        foreach ($result as $value) {
        	$id = $value['id'];
        	$res[$id] = $value['name'];
        }
        return $res;
    }
}
