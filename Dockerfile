# 使用 Node.js 20 的 LTS 版本，bullseye-slim 变体 (或其他兼容版本)
FROM --platform=linux/amd64 node:lts-bullseye-slim
# 或者: FROM --platform=linux/amd64 node:20-bullseye-slim
# 或者: FROM --platform=linux/amd64 node:18-bullseye-slim (确保版本 >= 18.18.0)

WORKDIR /app

# 优化1：仅复制包管理文件以利用 Docker 缓存
# 现在，这一步应该能找到 yarn.lock 了
COPY package.json yarn.lock ./

# 优化2：使用 --frozen-lockfile (或 Yarn v2+ 的 --immutable) 确保使用锁文件中的确切版本
RUN yarn install --frozen-lockfile
# 对于 Yarn Classic (v1)，如果不想严格冻结，可以用:
# RUN yarn install

# 复制剩余的应用程序代码
COPY . .

RUN yarn build

EXPOSE 3000

CMD ["yarn","start"]
