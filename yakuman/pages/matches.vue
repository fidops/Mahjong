<template>
    <v-container>
        <h1>戦一覧</h1>
        <v-spacer></v-spacer>
        <v-breadcrumbs :items="items" large></v-breadcrumbs>
        <v-spacer></v-spacer>

        <v-data-table
            item-key="id"
            :headers="headers"
            :items="matchesWithJansou"
            class="row-pointer"
            :loading="loading"
            loading-text="よみこみちゅう..."
            @click:row="onClickRow"
        >
        </v-data-table>
    </v-container>
</template>

<script lang="ts">
import Vue from 'vue'
import { Match } from '~/types/IMatch'
import { Jansou } from '~/types/IJansou'

type MatchWithJansou = Match & {
    jansouName: string
}

export default Vue.extend({
    name: 'MahjongMatch',
    data: () => ({
        items: [
            { text: 'Top', disabled: false, href: '/' },
            { text: '戦一覧', disabled: true, href: '/matches' },
        ],
        matches: [] as Match[],
        jansous: [] as Jansou[],
        matchesWithJansou: [] as MatchWithJansou[],
        headers: [
            { text: '名前', value: 'name' },
            { text: '雀荘', value: 'jansouName' },
            { text: '開催日', value: 'created_at' },
        ],
        loading: true,
    }),
    async fetch() {
        try {
            this.matches = await this.$axios.$get('/matches')
            this.jansous = await this.$axios.$get('/jansous')
        } catch (_err: any) {
            return
        }

        this.assignMatchesWithJansou()
        this.loading = false
    },
    methods: {
        assignMatchesWithJansou() {
            const matchesWithJansou = [] as MatchWithJansou[]
            this.matches.forEach((match) => {
                const jansou = this.jansous.find(
                    (jansou) => jansou.id === match.jansou_id
                )
                const jansouName =
                    jansou !== undefined ? jansou.name : 'Undefined'
                matchesWithJansou.push(Object.assign({}, match, { jansouName }))
            })
            this.matchesWithJansou = matchesWithJansou
        },
        onClickRow(_: any, { item }) {
            this.$router.push(`/match/${item.id}`)
        },
    },
})
</script>

<style scoped>
.row-pointer >>> tbody tr :hover {
    cursor: pointer;
}
</style>
