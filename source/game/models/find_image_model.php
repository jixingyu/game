<?php
/**
 *
 * Find image model
 *
 * @author  Xy Ji
 */
class Find_image_model extends MY_Model
{
    public $table = 'find_image';

    public function tag_image($tagId) {
        $sql = "select count(*) as cnt from {$this->table} where tags='{$tagId}' or tags like '{$tagId},%' or tags like '%,{$tagId},%' or tags like '%,{$tagId}'";
        $query = $this->db->query($sql);

        return $query->row_array();
    }

    public function get_images($limit = 200)
    {
        $sql = "select tags,type,file_name from {$this->table} limit {$limit}";
        $query=$this->db->query($sql);

        return $query->result_array();
    }
}
