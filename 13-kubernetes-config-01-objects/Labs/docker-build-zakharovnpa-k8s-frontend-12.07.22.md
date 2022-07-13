### Лог создания образа Frontend

```
root@PC-Ubuntu:~/netology-project/devkub-homeworks/13-kubernetes-config/frontend# docker build -t zakharovnpa/k8s-frontend:12.07.22 .
Sending build context to Docker daemon  430.6kB
Step 1/15 : FROM node:lts-buster as builder
 ---> b9f398d30e45
Step 2/15 : ENV BASE_URL=http://b-pod:9000
 ---> Running in dd09fe34c766
Removing intermediate container dd09fe34c766
 ---> 10c8e1edde68
Step 3/15 : RUN mkdir /app
 ---> Running in f66f1a0457ff
Removing intermediate container f66f1a0457ff
 ---> 57e1b1c5052e
Step 4/15 : WORKDIR /app
 ---> Running in 32f66d42fc80
Removing intermediate container 32f66d42fc80
 ---> ced355f9093e
Step 5/15 : ADD package.json /app/package.json
 ---> c0ec9943dfb0
Step 6/15 : ADD package-lock.json /app/package-lock.json
 ---> c20e4a3bb838
Step 7/15 : RUN npm i
 ---> Running in 3d7c54e02e81
 ```
 
**Красным цветом ###################################################### Красным цветом**
```
npm WARN old lockfile 
npm WARN old lockfile The package-lock.json file was created with an old version of npm,
npm WARN old lockfile so supplemental metadata must be fetched from the registry.
npm WARN old lockfile 
npm WARN old lockfile This is a one-time fix-up, please be patient...
npm WARN old lockfile 
npm WARN deprecated urix@0.1.0: Please see https://github.com/lydell/urix#deprecated
npm WARN deprecated source-map-url@0.4.1: See https://github.com/lydell/source-map-url#deprecated
npm WARN deprecated stable@0.1.8: Modern JS already guarantees Array#sort() is a stable sort, so this library is deprecated. See the compatibility table on MDN: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/sort#browser_compatibility
npm WARN deprecated source-map-resolve@0.5.3: See https://github.com/lydell/source-map-resolve#deprecated
npm WARN deprecated resolve-url@0.2.1: https://github.com/lydell/resolve-url#deprecated
npm WARN deprecated uuid@3.4.0: Please upgrade  to version 7 or higher.  Older versions may use Math.random() in certain circumstances, which is known to be problematic.  See https://v8.dev/blog/math-random for details.
npm WARN deprecated querystring@0.2.0: The querystring API is considered Legacy. new code should use the URLSearchParams API instead.
npm WARN deprecated svgo@1.3.2: This SVGO version is no longer supported. Upgrade to v2.x.x.
npm WARN deprecated @babel/polyfill@7.12.1: 🚨 This package has been deprecated in favor of separate inclusion of a polyfill and regenerator-runtime (when needed). See the @babel/polyfill docs (https://babeljs.io/docs/en/babel-polyfill) for more information.
npm WARN deprecated chokidar@2.1.8: Chokidar 2 does not receive security updates since 2019. Upgrade to chokidar 3 with 15x fewer dependencies
npm WARN deprecated chokidar@2.1.8: Chokidar 2 does not receive security updates since 2019. Upgrade to chokidar 3 with 15x fewer dependencies
npm WARN deprecated core-js@2.6.12: core-js@<3.23.3 is no longer maintained and not recommended for usage due to the number of issues. Because of the V8 engine whims, feature detection in old core-js versions could cause a slowdown up to 100x even if nothing is polyfilled. Some versions have web compatibility issues. Please, upgrade your dependencies to the actual version of core-js.

```
```
added 1013 packages, and audited 1014 packages in 1m

64 packages are looking for funding
  run `npm fund` for details

31 vulnerabilities (6 moderate, 22 high, 3 critical)

To address issues that do not require attention, run:
  npm audit fix

To address all issues (including breaking changes), run:
  npm audit fix --force

Run `npm audit` for details.
```


**Красным цветом ###################################################### Красным цветом**
```
npm notice 
npm notice New minor version of npm available! 8.11.0 -> 8.13.2
npm notice Changelog: <https://github.com/npm/cli/releases/tag/v8.13.2>
npm notice Run `npm install -g npm@8.13.2` to update!
npm notice 
```
```
Removing intermediate container 3d7c54e02e81
 ---> 4ecb558b1ada
Step 8/15 : ADD . /app
 ---> f1737c14a8fa
Step 9/15 : RUN npm run build && rm -rf /app/node_modules
 ---> Running in b1977999272e

> devops-testapp@1.0.0 build
> cross-env NODE_ENV=production webpack --config webpack.config.js --mode production

ℹ Compiling Production build progress
```
**Красным цветом ###################################################### Красным цветом**
```
Browserslist: caniuse-lite is outdated. Please run:
npx browserslist@latest --update-db

Why you should do it regularly:
https://github.com/browserslist/browserslist#browsers-data-updating
✔ Production build progress: Compiled successfully in 2.55s
```
```
Hash: ec3f8bf57db6746b49f5
Version: webpack 4.46.0
Time: 2554ms
Built at: 07/12/2022 2:51:44 PM
   Asset      Size  Chunks             Chunk Names
main.css  2.46 KiB       0  [emitted]  main
 main.js  3.16 KiB       0  [emitted]  main
Entrypoint main = main.css main.js
[0] ./styles/index.less 39 bytes {0} [built]
[1] ./js/index.js + 1 modules 3.78 KiB {0} [built]
    | ./js/index.js 3.73 KiB [built]
    | ./js/config.js 43 bytes [built]
    + 2 hidden modules
Child mini-css-extract-plugin node_modules/css-loader/dist/cjs.js!node_modules/postcss-loader/src/index.js??ref--6-2!node_modules/group-css-media-queries-loader/lib/index.js!node_modules/less-loader/dist/cjs.js!styles/index.less:
    Entrypoint mini-css-extract-plugin = *
    [1] ./node_modules/css-loader/dist/cjs.js!./node_modules/postcss-loader/src??ref--6-2!./node_modules/group-css-media-queries-loader/lib!./node_modules/less-loader/dist/cjs.js!./styles/index.less 1.3 KiB {0} [built]
    [2] ./node_modules/css-loader/dist/cjs.js!./styles/normalize.css 6.59 KiB {0} [built]
        + 1 hidden module
Removing intermediate container b1977999272e
 ---> 85700754d3cb
Step 10/15 : FROM nginx:latest
 ---> 55f4b40fe486
Step 11/15 : RUN mkdir /app
 ---> Using cache
 ---> eb2495b33cd2
Step 12/15 : WORKDIR /app
 ---> Using cache
 ---> dd332f3a8cec
Step 13/15 : COPY --from=builder /app/ /app
 ---> e4108bea1b80
Step 14/15 : RUN mv /app/markup/* /app && rm -rf /app/markup
 ---> Running in 5f4ef0f35921
Removing intermediate container 5f4ef0f35921
 ---> 28fc3540712d
Step 15/15 : ADD demo.conf /etc/nginx/conf.d/default.conf
 ---> 6de187abe181
Successfully built 6de187abe181
Successfully tagged zakharovnpa/k8s-frontend:12.07.22

```
### Вторая попытка. В первой попытке ENV былпрописан для образа node:lts-buster, а надо для nginx:latest

```
root@PC-Ubuntu:~/netology-project/devkub-homeworks/13-kubernetes-config/frontend# docker build -t zakharovnpa/k8s-frontend:12.07.22 .
Sending build context to Docker daemon  430.6kB
Step 1/15 : FROM node:lts-buster as builder
 ---> b9f398d30e45
Step 2/15 : RUN mkdir /app
 ---> Using cache
 ---> f16fcbd21ee6
Step 3/15 : WORKDIR /app
 ---> Using cache
 ---> 6812598cb3ad
Step 4/15 : ADD package.json /app/package.json
 ---> Using cache
 ---> 6e4c1b5ae040
Step 5/15 : ADD package-lock.json /app/package-lock.json
 ---> Using cache
 ---> ecef30491f9a
Step 6/15 : RUN npm i
 ---> Using cache
 ---> a154e3d6e8c3
Step 7/15 : ADD . /app
 ---> 77bfd76ef3e7
Step 8/15 : RUN npm run build && rm -rf /app/node_modules
 ---> Running in 613f2931f6fb

> devops-testapp@1.0.0 build
> cross-env NODE_ENV=production webpack --config webpack.config.js --mode production

ℹ Compiling Production build progress
```
**Красным цветом ###################################################### Красным цветом**
```
Browserslist: caniuse-lite is outdated. Please run:
npx browserslist@latest --update-db

Why you should do it regularly:
https://github.com/browserslist/browserslist#browsers-data-updating
```
```
✔ Production build progress: Compiled successfully in 3.44s
Hash: ec3f8bf57db6746b49f5
Version: webpack 4.46.0
Time: 3445ms
Built at: 07/12/2022 3:05:04 PM
   Asset      Size  Chunks             Chunk Names
main.css  2.46 KiB       0  [emitted]  main
 main.js  3.16 KiB       0  [emitted]  main
Entrypoint main = main.css main.js
[0] ./styles/index.less 39 bytes {0} [built]
[1] ./js/index.js + 1 modules 3.78 KiB {0} [built]
    | ./js/index.js 3.73 KiB [built]
    | ./js/config.js 43 bytes [built]
    + 2 hidden modules
Child mini-css-extract-plugin node_modules/css-loader/dist/cjs.js!node_modules/postcss-loader/src/index.js??ref--6-2!node_modules/group-css-media-queries-loader/lib/index.js!node_modules/less-loader/dist/cjs.js!styles/index.less:
    Entrypoint mini-css-extract-plugin = *
    [1] ./node_modules/css-loader/dist/cjs.js!./node_modules/postcss-loader/src??ref--6-2!./node_modules/group-css-media-queries-loader/lib!./node_modules/less-loader/dist/cjs.js!./styles/index.less 1.3 KiB {0} [built]
    [2] ./node_modules/css-loader/dist/cjs.js!./styles/normalize.css 6.59 KiB {0} [built]
        + 1 hidden module
```
**Красным цветом ###################################################### Красным цветом**
```
npm notice 
npm notice New minor version of npm available! 8.11.0 -> 8.13.2
npm notice Changelog: <https://github.com/npm/cli/releases/tag/v8.13.2>
npm notice Run `npm install -g npm@8.13.2` to update!
npm notice 
```
```
Removing intermediate container 613f2931f6fb
 ---> 9b9178191a65
Step 9/15 : FROM nginx:latest
 ---> 55f4b40fe486
Step 10/15 : ENV BASE_URL=http://b-pod:9000
 ---> Running in a8d718889689
Removing intermediate container a8d718889689
 ---> e49e73744255
Step 11/15 : RUN mkdir /app
 ---> Running in 843abcb6c9cf
Removing intermediate container 843abcb6c9cf
 ---> a7d919ef6b97
Step 12/15 : WORKDIR /app
 ---> Running in 4e743f4ea007
Removing intermediate container 4e743f4ea007
 ---> 8cdb681962b4
Step 13/15 : COPY --from=builder /app/ /app
 ---> 4c633297da24
Step 14/15 : RUN mv /app/markup/* /app && rm -rf /app/markup
 ---> Running in a30040d3f1d6
Removing intermediate container a30040d3f1d6
 ---> 22e0130f4034
Step 15/15 : ADD demo.conf /etc/nginx/conf.d/default.conf
 ---> dc84bb688414
Successfully built dc84bb688414
Successfully tagged zakharovnpa/k8s-frontend:12.07.22

```
