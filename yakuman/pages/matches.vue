<template>
    <main>
        <a-page-header title="戦一覧" :breadcrumb="{ props: { routes } }" />
        <a-spin size="large" tip="loading..." :spinning="loading">
            <a-table
                :data-source="matchesWithJansou"
                :columns="columns"
            >
                <span slot="nameRenderer" slot-scope="name, record">
                    <NuxtLink :to="`/match/${record.id}`">{{ name }}</NuxtLink>
                </span>
            </a-table>
        </a-spin>
    </main>
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
        routes: [
            { path: '/', breadcrumbName: 'Home' },
            { path: '/matches', breadcrumbName: 'matches' },
        ],
        matches: [] as Match[],
        jansous: [] as Jansou[],
        matchesWithJansou: [] as MatchWithJansou[],
        columns: [
            {
                title: 'Name',
                dataIndex: 'name',
                key: 'name',
                scopedSlots: { customRender: 'nameRenderer' },
            },
            {
                title: 'Jansou',
                dataIndex: 'jansouName',
                key: 'jansouName',
            },
            {
                title: 'Held at',
                dataIndex: 'created_at',
                key: 'created_at',
            },
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
    },
})
</script>
