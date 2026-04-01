import { defineConfig } from 'vite'
import rabbita from '@rabbita/vite'

export default defineConfig({
  base: '/MGPIC2026/',
  plugins: [rabbita()],
})
