<template>
    <v-container>
        <h1>戦績一覧</h1>
        <v-spacer></v-spacer>
        <v-breadcrumbs :items="items" large></v-breadcrumbs>
        <v-spacer></v-spacer>

        <v-simple-table dense>
            <template v-slot:default>
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
import { Game } from '~/types/IGame'
import { Member } from '~/types/IMember'

export default Vue.extend({
    name: 'MahjongGame',
    data: () => ({
        items: [
            { text: 'Top', disabled: false, href: '/' },
            { text: '戦績一覧', disabled: true, href: '/games' },
        ],
        games: [] as Game[],
        members: [] as Member[],
        loading: true,
    }),
    async fetch() {
        try {
            this.games = await this.$axios.$get('/games')
            this.members = await this.$axios.$get('/members')
        } catch (_err: any) {
            return
        }
        this.loading = false
    },
    methods: {
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
