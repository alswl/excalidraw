FROM node:18 AS build

ARG CHINA_MIRROR=false

# enable china mirror
RUN if [[ "$CHINA_MIRROR" = "true" ]] ; then \
    echo "Enable China Alpine Mirror" && \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories; \
    fi

RUN if [[ "$CHINA_MIRROR" = "true" ]] ; then \
    echo "Enable China NPM Mirror" && \
    npm install -g cnpm --registry=https://registry.npmmirror.com; \
    npm config set registry https://registry.npmmirror.com; \
    fi

WORKDIR /opt/node_app

COPY package.json yarn.lock ./
RUN yarn --ignore-optional --network-timeout 600000

ARG NODE_ENV=production

COPY . .
# disable webpack env loader, use dynamic env
RUN sed -i 's/import.meta.env/window._env_/g' $(grep 'import.meta.env' -R -l --include "*.ts" --include "*.tsx" --exclude-dir node_modules .)
RUN yarn build:app:docker

FROM nginx:1.21-alpine

ARG CHINA_MIRROR=false

# enable china mirror
RUN if [[ "$CHINA_MIRROR" = "true" ]] ; then \
    echo "Enable China Alpine Mirror" && \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories; \
    fi

RUN apk update && apk add sed bash python3 py3-pip

# enable china mirror
RUN if [[ "$CHINA_MIRROR" = "true" ]] ; then \
    echo "Enable China NPM Mirror" && \
    pip3 config set global.index-url https://mirrors.aliyun.com/pypi/simple; \
    fi

RUN pip3 install beautifulsoup4

# env from upstream .env.production

ENV VITE_APP_BACKEND_V2_GET_URL=https://json.excalidraw.com/api/v2/
ENV VITE_APP_BACKEND_V2_POST_URL=https://json.excalidraw.com/api/v2/post/
ENV VITE_APP_LIBRARY_URL=https://libraries.excalidraw.com
ENV VITE_APP_LIBRARY_BACKEND=https://us-central1-excalidraw-room-persistence.cloudfunctions.net/libraries
ENV VITE_APP_PORTAL_URL=https://portal.excalidraw.com
ENV VITE_APP_PLUS_LP=https://plus.excalidraw.com
ENV VITE_APP_PLUS_APP=https://app.excalidraw.com
ENV VITE_APP_WS_SERVER_URL=""
ENV VITE_APP_FIREBASE_CONFIG='{"apiKey":"AIzaSyAd15pYlMci_xIp9ko6wkEsDzAAA0Dn0RU","authDomain":"excalidraw-room-persistence.firebaseapp.com","databaseURL":"https://excalidraw-room-persistence.firebaseio.com","projectId":"excalidraw-room-persistence","storageBucket":"excalidraw-room-persistence.appspot.com","messagingSenderId":"654800341332","appId":"1:654800341332:web:4a692de832b55bd57ce0c1"}'
ENV VITE_APP_DISABLE_TRACKING=""

COPY --from=build /opt/node_app/build /usr/share/nginx/html
COPY launcher.py /

HEALTHCHECK CMD wget -q -O /dev/null http://localhost || exit 1
EXPOSE 80

CMD ["python3", "/launcher.py", "/usr/share/nginx/html"]
