<?php
/**
 *
 * Spot image model
 *
 * @author  Xy Ji
 */
class Spot_image_model extends MY_Model
{
    public $table = 'spot_image';
    public function get_images($limit = 20)
    {
        $sql = "select image_ori,image_mod,coordinate from {$this->table} order by rand() limit {$limit}";
        $query=$this->db->query($sql);

        return $query->result_array();
    }
}
