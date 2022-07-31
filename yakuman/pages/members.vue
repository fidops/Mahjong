<template>
    <v-container>
        <h1>雀士一覧</h1>
        <v-spacer></v-spacer>
        <v-breadcrumbs :items="items" large></v-breadcrumbs>
        <v-spacer></v-spacer>
        <v-data-table
            item-key="id"
            :headers="headers"
            :items="members"
            :items-per-page="10"
            :loading="loading"
            loading-text="よみこみちゅう..."
        ></v-data-table>
    </v-container>
</template>

<script lang="ts">
import Vue from 'vue'
import { Member } from '~/types/IMember'

export default Vue.extend({
    name: 'FidopMember',
    data: () => ({
        routes: [
            { path: '/', breadcrumbName: 'Home' },
            { path: '/members', breadcrumbName: 'members' },
        ],
        items: [
            { text: 'Top', disabled: false, href: '/' },
            { text: '雀士一覧', disabled: true, href: '/members' },
        ],
        loading: true,
        members: [] as Member[],
        headers: [
            { text: '名前', value: 'name' },
            { text: 'Discord ID', value: 'discord_id' }
        ],
    }),
    async fetch() {
        try {
            this.members = await this.$axios.$get('/members')
        } catch (_err: any) {
            return
        }
        this.loading = false
    },
})
</script>
