# 1. Chọn Node.js image chính thức
FROM node:18-alpine

# 2. Tạo thư mục làm việc trong container
WORKDIR /app

# 3. Copy package.json trước (tối ưu cache)
COPY package*.json ./

# 4. Cài dependencies
RUN npm install

# 5. Copy toàn bộ source code
COPY . .

# 6. Mở cổng 3002
EXPOSE 3002

# 7. Chạy app
CMD ["npm", "start"]
