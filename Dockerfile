# 使用 Node.js 20 的 LTS 版本，bullseye-slim 变体
# 你也可以选择一个更具体的版本，如 node:20.11.1-bullseye-slim (请检查 Docker Hub 上最新的 LTS补丁版本)
# 或者直接使用 'lts' 标签，它通常指向最新的 LTS 版本 (当前是 Node 20)
FROM --platform=linux/amd64 node:lts-bullseye-slim
# 或者更具体地指定 Node 20:
# FROM --platform=linux/amd64 node:20-bullseye-slim

WORKDIR /app

# 优化1：仅复制包管理文件以利用 Docker 缓存
# 这样，只有当 package.json 或 yarn.lock 改变时，yarn install 才会重新运行
COPY package.json yarn.lock ./

# 优化2：使用 --frozen-lockfile (或 Yarn v2+ 的 --immutable) 确保使用锁文件中的确切版本
# 这在 CI/CD 和生产构建中是最佳实践
RUN yarn install --frozen-lockfile
# 如果你使用的是 Yarn v1 并且不想那么严格，可以只用 'yarn install'
# RUN yarn install

# 复制剩余的应用程序代码
COPY . .

RUN yarn build

EXPOSE 3000

CMD ["yarn","start"]
