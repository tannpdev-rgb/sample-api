const {ChromaClient} = require("chromadb")
// ===== Chroma Class =====

class Chroma {
  static client = null
  static collection = null

  /**
   * Khởi tạo Chroma với retry
   * @param {number} retries - số lần retry
   * @param {number} delay - delay giữa các lần retry (ms)
   */
  static async initWRetry(retries = 1, delay = 10_000) {

    for (let attempt = 1; attempt <= retries; attempt++) {
      try {
        this.client = new ChromaClient({
          host: "chroma",
          port: 8000,
          ssl: false,
        })

        this.collection = await this.client.getOrCreateCollection({
          name: "posts",
        })

        console.log(`Connected to ChromaDB on attempt ${attempt}`)
        return
      } catch (error) {
        console.error(`Attempt ${attempt} failed:`, error)

        if (attempt < retries) {
          console.log(`Retrying in ${delay / 1000} seconds...`)
          await new Promise((resolve) => setTimeout(resolve, delay))
        } else {
          console.error("All retry attempts failed.")
          throw error
        }
      }
    }
  }
}

module.exports = Chroma
