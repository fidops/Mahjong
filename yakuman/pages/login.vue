<template>
    <v-container>
        <h1>Login</h1>
        <v-alert
            color="red"
            dense
            outlined
            type="error"
            v-if="!!error"
        >{{ error }}</v-alert>
        <v-form ref="form" @submit.prevent="handleLogin">
            <v-text-field
                v-model="auth.userid"
                :rules="[rules.required]"
                type="text"
                prepend-icon="mdi-account"
                label="User ID"
                required
            ></v-text-field>
            <v-text-field
                v-model="auth.password"
                :rules="[rules.required]"
                type="password"
                prepend-icon="mdi-shield-key"
                label="Password"
                required
            ></v-text-field>
            <v-btn type="submit" color="success" class="mr-4">
                Submit
            </v-btn>
        </v-form>
    </v-container>
</template>

<script lang="ts">
import Vue from 'vue'
import { HTTPResponse } from '@nuxtjs/auth-next'

export default Vue.extend({
    auth: false,
    name: 'LoginYakuman',
    data: () => ({
        auth: {
            userid: '',
            password: '',
        },
        rules: {
            required: (value: string) => !!value || '必須です。',
        },
        error: '',
    }),
    methods: {
        async handleLogin() {
            if (!this.$refs.form.validate()) {
                return
            }

            let response: HTTPResponse
            try {
                response = (await this.$auth.loginWith('local', {
                    data: { auth: { ...this.auth } },
                })) as HTTPResponse
            } catch (err: any) {
                if (err.response.status === 404) {
                    this.error = 'userid もしくは password が違います。'
                } else {
                    this.error = `ステータスコード${err.response.status}が返されました。詳細はコンソールを確認してください。`
                }
                return
            }

            // this.$auth.loggedIn を正しく機能させるため、ユーザのIDをここで割り当てる。
            this.$auth.setUser({ id: response.data.id })

            // ログイン後リダイレクトが auth-next の上で正しく動作しないので $router.push を用いる。
            // FIX ME
            const redirect = this.$auth.$storage.getUniversal(
                'redirect'
            ) as string
            this.$router.push(redirect)
        },
    },
})
</script>
