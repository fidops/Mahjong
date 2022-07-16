export interface MahjongGame {
    id: number
    east_id: string
    south_id: string
    west_id: string
    north_id: string | null
    east_score: number
    south_score: number
    west_score: number
    north_score: number | null
    mahjong_match_id: number
}
