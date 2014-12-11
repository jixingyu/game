<?php
/**
 *
 * Game log model
 *
 * @author  Xy Ji
 */
class Game_log_model extends MY_Model
{
    public $table = 'game_log';

    public function prize_count($where = '', $groupBy = false)
    {
        $this->db->select("{$groupBy}, count(*) as cnt");
        $this->db->from($this->table);

        if (!empty($where)) {
            $this->db->where($where);
        }
        if (!empty($groupBy)) {
            $this->db->group_by($groupBy);
        }

        $query = $this->db->get()->result_array();

        return $query;
    }
}
