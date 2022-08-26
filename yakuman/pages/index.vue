<template>
    <v-container>
        <h1>Yakuman Top</h1>
        <v-spacer></v-spacer>
        <v-breadcrumbs :items="items" large></v-breadcrumbs>
        <v-spacer></v-spacer>
        <div>
            <v-sheet
                tile
                height="54"
                class="d-flex"
            >
            <v-btn
                icon
                class="ma-2"
                @click="$refs.calendar.prev()"
            >
                <v-icon>mdi-chevron-left</v-icon>
            </v-btn>
            <v-select
                v-model="type"
                :items="types"
                dense
                outlined
                hide-details
                class="ma-2"
                label="カレンダー表示"
            ></v-select>
            <v-select
                v-model="weekday"
                :items="weekdays"
                dense
                outlined
                hide-details
                label="週表示"
                class="ma-2"
            ></v-select>
            <v-spacer></v-spacer>
            <v-btn
                icon
                class="ma-2"
                @click="$refs.calendar.next()"
            >
                <v-icon>mdi-chevron-right</v-icon>
            </v-btn>
            </v-sheet>
            <v-sheet height="600">
                <v-calendar
                    ref="calendar"
                    :weekdays="weekday"
                    :type="type"
                ></v-calendar>
            </v-sheet>
        </div>
    </v-container>
</template>

<script lang="ts">
import Vue from 'vue'

export default Vue.extend({
    name: 'IndexPage',
    data: () => ({
        items: [
            { text: 'Top', disabled: true, href: '/' }
        ],
        type: 'month',
        types: [
            { text: '月', value: 'month' },
            { text: '週', value: 'week' },
            { text: '日', value: 'day' },
        ],
        weekday: [1, 2, 3, 4, 5, 6, 0],
        weekdays: [
            { text: '月 - 日', value: [1, 2, 3, 4, 5, 6, 0] },
            { text: '日 - 土', value: [0, 1, 2, 3, 4, 5, 6] },
            { text: '月 - 金', value: [1, 2, 3, 4, 5] },
        ],
    }),
})
</script>
