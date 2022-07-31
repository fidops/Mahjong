<template>
    <v-container>
        <h1>戦績一覧</h1>
        <v-spacer></v-spacer>
        <v-breadcrumbs :items="items" large></v-breadcrumbs>
        <v-spacer></v-spacer>

        <v-data-table
            item-key="id"
            :headers="headers"
            :items="tableFormattedGames"
            :items-per-page="20"
            :loading="loading"
            loading-text="よみこみちゅう..."
        >
        </v-data-table>
    </v-container>
</template>

<script lang="ts">
import Vue from 'vue'
import { Game } from '~/types/IGame'
import { Member } from '~/types/IMember'

interface TableHeader {
    text: string
    value: string
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
        items: [
            { text: 'Top', disabled: false, href: '/' },
            { text: '戦績一覧', disabled: true, href: '/games' },
        ],
        games: [] as Game[],
        members: [] as Member[],
        tableFormattedGames: [] as UuidWithScore[],
        headers: [] as TableHeader[],
        paginationOptions: {
            pageSize: 20,
        },
        loading: true,
    }),
    async fetch() {
        try {
            this.games = await this.$axios.$get('/games')
            this.members = await this.$axios.$get('/members')
        } catch (_err: any) {
            return
        }

        this.assignTableFormattedGames()
        this.assignHeaders()
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
        assignHeaders() {
            const headers = [] as TableHeader[]
            this.members.forEach((member) => {
                headers.push({
                    text: member.name,
                    value: member.id,
                })
            })
            this.headers = headers
        },
    },
})
</script>
