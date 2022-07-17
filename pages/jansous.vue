<template>
    <main>
        <a-page-header title="雀荘一覧" :breadcrumb="{ props: { routes } }" />
        <a-spin size="large" tip="loading..." :spinning="loading">
            <a-table :data-source="jansous" :columns="columns"></a-table>
        </a-spin>
    </main>
</template>

<script lang="ts">
import Vue from 'vue'
import { Jansou } from '~/types/IJansou'

export default Vue.extend({
    name: 'MahjongMatch',
    data: () => ({
        routes: [
            { path: '/', breadcrumbName: 'Home' },
            { path: '/jansous', breadcrumbName: 'jansous' },
        ],
        jansous: [] as Jansou[],
        columns: [
            {
                title: 'Name',
                dataIndex: 'name',
                key: 'name',
            },
            {
                title: 'GoogleMap',
                dataIndex: 'google_map_url',
                key: 'google_map_url',
            },
            {
                title: 'Address',
                dataIndex: 'address',
                key: 'address',
            },
        ],
        loading: true,
    }),
    async fetch() {
        try {
            this.jansous = await this.$axios.$get('/jansous')
        } catch (_err: any) {
            return
        }

        this.loading = false
    },
})
</script>
