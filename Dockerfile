# 使用一个兼容的 Node.js LTS 版本
FROM --platform=linux/amd64 node:20-bullseye-slim

WORKDIR /app

RUN yarn instal
# 拷贝 package.json 和 yarn.lock
# 如果 yarn.lock 存在，yarn install --frozen-lockfile 会确保使用 lock 文件中的版本并且不会修改它

# 拷贝项目的其余文件
COPY . .

# 构建应用
RUN yarn build

EXPOSE 3000

CMD ["yarn","start"]
