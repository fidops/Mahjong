<template>
    <main>
        <a-page-header title="戦一覧" :breadcrumb="{ props: { routes } }" />
        <a-spin size="large" tip="loading..." :spinning="loading">
            <a-table
                :data-source="matchesWithJansou"
                :columns="columns"
            ></a-table>
        </a-spin>
    </main>
</template>

<script lang="ts">
import Vue from 'vue'
import { MahjongMatch } from '~/types/IMahjongMatch'
import { MahjongJansou } from '~/types/IMahjongJansou'

type MatchWithJansou = MahjongMatch & {
    jansouName: string
}

export default Vue.extend({
    name: 'MahjongMatch',
    data: () => ({
        routes: [
            { path: '/', breadcrumbName: 'Home' },
            { path: '/matches', breadcrumbName: 'matches' },
        ],
        matches: [] as MahjongMatch[],
        jansous: [] as MahjongJansou[],
        matchesWithJansou: [] as MatchWithJansou[],
        columns: [
            {
                title: 'Name',
                dataIndex: 'name',
                key: 'name',
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
            this.matches = await this.$axios.$get('/mahjong_matches')
            this.jansous = await this.$axios.$get('/mahjong_jansous')
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
                    (jansou) => jansou.id === match.mahjong_jansou_id
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
