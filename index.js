const express = require('express')
const app = express()
const port = 3002
const axios = require("axios")

app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.get("/chroma", async (req, res) => {
  try {
    const response = await axios.get("http://chroma:8000/api/v1/heartbeat")
    res.json(response.data)
  } catch (err) {
    res.status(500).json({ error: err.message })
  }
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})