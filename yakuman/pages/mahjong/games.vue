<template>
    <main>
        <a-page-header title="戦績一覧" :breadcrumb="{ props: { routes } }" />
        <a-spin size="large" tip="loading..." :spinning="loading">
            <a-table
                :data-source="tableFormattedGames"
                :columns="columns"
                :pagination="paginationOptions"
            >
                <span slot="scoreSlot" slot-scope="score, record">
                    <span v-if="!loading && score == null">-</span>
                    <a-badge
                        v-else-if="!record.sanma && score >= 30000"
                        status="success"
                        :text="String(score)"
                    />
                    <a-badge
                        v-else-if="!record.sanma && score < 30000"
                        status="error"
                        :text="String(score)"
                    />
                    <a-badge
                        v-else-if="record.sanma && score >= 40000"
                        status="success"
                        :text="String(score)"
                    />
                    <a-badge
                        v-else-if="record.sanma && score < 40000"
                        status="error"
                        :text="String(score)"
                    />
                </span>
            </a-table>
        </a-spin>
    </main>
</template>

<script lang="ts">
import Vue from 'vue'
import { MahjongGame } from '~/types/IMahjongGame'
import { Member } from '~/types/IMember'

interface ColumnObject {
    title: string
    dataIndex: string
    key: string
    scopedSlots?: { customRender: string }
}

interface UuidWithScore {
    [key: string]: number | null
}

type TableFormattedGame = UuidWithScore & {
    id: number
    sanma: boolean
}

export default Vue.extend({
    name: 'MahjongGame',
    data: () => ({
        routes: [
            { path: '/', breadcrumbName: 'Home' },
            { path: '/games', breadcrumbName: 'games' },
        ],
        games: [] as MahjongGame[],
        members: [] as Member[],
        tableFormattedGames: [] as UuidWithScore[],
        columns: [] as ColumnObject[],
        paginationOptions: {
            pageSize: 20,
        },
        loading: true,
    }),
    async fetch() {
        try {
            this.games = await this.$axios.$get('/mahjong_games')
            this.members = await this.$axios.$get('/members')
        } catch (_err: any) {
            return
        }

        this.assignTableFormattedGames()
        this.assignColumns()
        this.loading = false
    },
    methods: {
        assignTableFormattedGames() {
            const uuidWithScoresBase = {} as TableFormattedGame
            this.members.forEach((member) => {
                uuidWithScoresBase[member.id] = null
            })

            const tableFormattedGames = [] as TableFormattedGame[]
            this.games.forEach((game) => {
                let uuidWithScores = {} as TableFormattedGame
                if (game.north_id !== null && game.north_score !== null) {
                    uuidWithScores = Object.assign({}, uuidWithScoresBase, {
                        id: game.id,
                        sanma: false,
                        [game.east_id]: game.east_score,
                        [game.south_id]: game.south_score,
                        [game.west_id]: game.west_score,
                        [game.north_id]: game.north_score,
                    })
                } else {
                    uuidWithScores = Object.assign({}, uuidWithScoresBase, {
                        id: game.id,
                        sanma: true,
                        [game.east_id]: game.east_score,
                        [game.south_id]: game.south_score,
                        [game.west_id]: game.west_score,
                    })
                }
                tableFormattedGames.push(uuidWithScores)
            })
            this.tableFormattedGames = tableFormattedGames
        },
        assignColumns() {
            const columns = [] as ColumnObject[]
            columns.push({
                title: 'ID',
                dataIndex: 'id',
                key: 'id',
            })
            this.members.forEach((member) => {
                columns.push({
                    title: member.name,
                    dataIndex: member.id,
                    key: member.id,
                    scopedSlots: { customRender: 'scoreSlot' },
                })
            })
            this.columns = columns
        },
    },
})
</script>
