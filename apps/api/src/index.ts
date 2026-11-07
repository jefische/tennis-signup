import express from 'express'
import type { HealthResponse } from '@tennis-signup/shared'

const app = express()
const port = Number(process.env.PORT ?? 3000)

app.use(express.json())

app.get('/api/health', (_req, res) => {
  const body: HealthResponse = { status: 'ok' }
  res.json(body)
})

app.listen(port, () => {
  console.log(`API listening on http://localhost:${port}`)
})
