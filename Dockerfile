# 使用一个兼容的 Node.js LTS 版本
FROM --platform=linux/amd64 node:20-bullseye-slim

WORKDIR /app

RUN yarn instal
# 拷贝 package.json 和 yarn.lock
# 如果 yarn.lock 存在，yarn install --frozen-lockfile 会确保使用 lock 文件中的版本并且不会修改它
# 这对于 CI/CD 环境很重要
COPY package.json yarn.lock ./

# 安装依赖
# --frozen-lockfile 确保 yarn.lock 不会被修改，如果 package.json 和 yarn.lock 不一致则会报错
# 如果你确定 yarn.lock 总是最新的，并且它已被提交到仓库，这是最佳实践
RUN yarn install --frozen-lockfile

# 拷贝项目的其余文件
COPY . .

# 构建应用
RUN yarn build

EXPOSE 3000

CMD ["yarn","start"]
