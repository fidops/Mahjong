<template>
    <v-container>
        <h1>戦 {{ match.name }}</h1>
        <v-spacer></v-spacer>
        <v-breadcrumbs :items="items" large></v-breadcrumbs>
        <v-spacer></v-spacer>

        <h2>順位基準</h2>
        <v-data-table
            item-key="id"
            :headers="headers"
            :items="tableBodyDatas"
            :items-per-page="20"
            :loading="loading"
            loading-text="よみこみちゅう..."
        >
            <template v-slot:item.first="{ item }">
                {{ getNameByUuid(item.first.uuid) }}
                <v-chip color="success" outlined small>
                    {{ item.first.score }} (+25)
                </v-chip>
            </template>
            <template v-slot:item.second="{ item }">
                {{ getNameByUuid(item.second.uuid) }}

                <v-chip color="pink" outlined x-small>
                    {{ item.second.score }} (+25)
                </v-chip>
            </template>
            <template v-slot:item.third="{ item }">
                {{ getNameByUuid(item.third.uuid) }}
                {{ item.third.score }} (+25)
            </template>
            <template v-slot:item.fourth="{ item }">
                {{ getNameByUuid(item.fourth.uuid) }}
                {{ item.fourth.score || '-' }} (+25)
            </template>
        </v-data-table>

        <h2>参加者基準</h2>
        <v-simple-table>
            <template>
                <thead>
                    <tr>
                        <th></th>
                        <th v-for="member in members" :key="member.id">
                            {{ getNameByUuid(member.id) }}
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="game in games" :key="game.id">
                        <td></td>
                        <td v-for="member in members" :key="member.id">
                            {{ getScore(game, member) }}
                        </td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <th>Summary</th>
                        <th v-for="member in members" :key="member.id">
                            {{ getNameByUuid(member.id) }}
                        </th>
                    </tr>
                </tfoot>
            </template>
        </v-simple-table>
    </v-container>
</template>

<script lang="ts">
import Vue from 'vue'
import { Match } from '~/types/IMatch'
import { Jansou } from '~/types/IJansou'
import { Game } from '~/types/IGame'
import { Member } from '~/types/IMember'

interface TableBodyScore {
    uuid: string | null
    score: number | null
}

interface TableBodyData {
    id: string
    sanma: boolean
    first: TableBodyScore
    second: TableBodyScore
    third: TableBodyScore
    fourth: TableBodyScore
}

export default Vue.extend({
    name: 'MahjongGameListOnMatch',
    data: () => ({
        items: [
            { text: 'Top', disabled: false, href: '/' },
            { text: '戦一覧', disabled: false, href: '/matches' },
            { text: '戦績', disabled: true, href: '' }
        ],
        match: {} as Match,
        games: [] as Game[],
        members: [] as Member[],
        headers: [
            { text: '1位', value: 'first' },
            { text: '2位', value: 'second' },
            { text: '3位', value: 'third' },
            { text: '4位', value: 'fourth' },
        ],
        tableBodyDatas: [] as TableBodyData[],
        loading: true,
    }),
    async fetch() {
        try {
            this.match = await this.$axios.$get(`/matches/${this.$route.params.id}`)
            this.games = await this.$axios.$get(`/matches/${this.$route.params.id}/games`)
            this.members = await this.$axios.$get(`/matches/${this.$route.params.id}/members`)
        } catch (_err: any) {
            return
        }

        this.assignTableBodyData()
        this.loading = false
    },
    methods: {
        // TODO: どうにかしてシンプルにしたい
        assignTableBodyData() {
            const tableBodyDatas = [] as TableBodyData[]
            this.games.forEach((game) => {
                let tableBodyData = {} as TableBodyData
                tableBodyData.id = game.id
                tableBodyData.sanma = true
                let playerScores = [
                    {
                        score: game.east_score,
                        uuid: game.east_id,
                    },
                    {
                        score: game.south_score,
                        uuid: game.south_id,
                    },
                    {
                        score: game.west_score,
                        uuid: game.west_id,
                    },
                ]
                if (game.north_id !== null && game.north_score !== null) {
                    tableBodyData.sanma = false
                    playerScores.push(
                        {
                            score: game.north_score,
                            uuid: game.north_id,
                        },
                    )
                }
                playerScores.sort((a, b) => b.score - a.score)
                tableBodyData.first = {
                    uuid: playerScores[0].uuid,
                    score: playerScores[0].score,
                }
                tableBodyData.second = {
                    uuid: playerScores[1].uuid,
                    score: playerScores[1].score
                }
                tableBodyData.third = {
                    uuid: playerScores[2].uuid,
                    score: playerScores[2].score
                }
                tableBodyData.fourth = {
                    uuid: (!tableBodyData.sanma) ? playerScores[3].uuid : null,
                    score: (!tableBodyData.sanma) ? playerScores[3].score : null,
                }
                tableBodyDatas.push(tableBodyData)
            })
            this.tableBodyDatas = tableBodyDatas
        },
        getNameByUuid(uuid: string) {
            const member = this.members.find(member => member.id === uuid)
            return (member !== undefined) ? member.name : '-'
        },
        getScore(game: Game, member: Member) {
            switch (member.id) {
                case game.east_id:
                    return game.east_score
                case game.north_id:
                    return game.north_score
                case game.west_id:
                    return game.west_score
                case game.south_id:
                    return game.south_score
                default:
                    return '-'
            }
        },
    },
})
</script>
